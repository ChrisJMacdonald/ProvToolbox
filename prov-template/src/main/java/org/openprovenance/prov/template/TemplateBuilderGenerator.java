package org.openprovenance.prov.template;

import javax.lang.model.element.Modifier;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Set;

import org.openprovenance.prov.model.Bundle;
import org.openprovenance.prov.model.Document;
import org.openprovenance.prov.model.Namespace;
import org.openprovenance.prov.model.ProvFactory;
import org.openprovenance.prov.model.ProvUtilities;
import org.openprovenance.prov.model.QualifiedName;
import org.openprovenance.prov.model.StatementOrBundle;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.MissingNode;
import com.squareup.javapoet.JavaFile;
import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.TypeSpec;
import com.squareup.javapoet.TypeSpec.Builder;

public class TemplateBuilderGenerator {
    
    final private ProvFactory pFactory;


    public TemplateBuilderGenerator(ProvFactory pFactory) {
        this.pFactory=pFactory;
    }
    
    static ProvUtilities u= new ProvUtilities();
    
    final GeneratorUtil gu=new GeneratorUtil();
    
    boolean withMain=true; // TODO need to be updatable via command line
   
    public boolean generate(Document doc, String templateName, String packge, String location, String resource, JsonNode bindings_schema) {
        try {
            String bn=templateNameClass(templateName);
            String destinationDir=location + "/" + packge.replace('.', '/') + "/";
            
            String destination=destinationDir + bn + ".java";
            JavaFile spec=generateBuilderSpecification(doc,bn,templateName,packge, resource, bindings_schema);
            PrintWriter out;
            try {
                File dir=new File(destinationDir);
                if (!dir.exists() && !dir.mkdirs()) {
                    System.err.println("failed to create directory " + destinationDir);
                    return false;
                };
                out = new PrintWriter(destination);
                out.print(spec);
                out.close();
                return true;
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;

        }
    }
    
    
    public String templateNameClass(String templateName) {
        return gu.capitalize(templateName)+"Builder";
    }

   
    public JavaFile generateBuilderSpecification(Document doc, String name, String templateName, String packge, String resource, JsonNode bindings_schema) {


        Bundle bun=u.getBundle(doc).get(0);
        
        Set<QualifiedName> allVars=new HashSet<QualifiedName>();
        Set<QualifiedName> allAtts=new HashSet<QualifiedName>();
        
        gu.extractVariablesAndAttributes(bun, allVars, allAtts, pFactory);
        
        return generateBuilderSpecification2(doc, allVars,allAtts,name, templateName, packge, resource, bindings_schema);
        
    }
    
   private JavaFile generateBuilderSpecification2(Document doc, Set<QualifiedName> allVars, Set<QualifiedName> allAtts, String name, String templateName, String packge, String resource, JsonNode bindings_schema) {
        
        
        Builder builder = gu.generateClassBuilder2(name);
        
        Hashtable<QualifiedName, String> vmap=generateQualifiedNames(doc,builder);

        
        builder.addMethod(gu.generateConstructor2(vmap));
        
        builder.addMethod(generateTemplateGenerator(allVars, allAtts, doc,vmap));
        
        builder.addMethod(nameAccessorGenerator(templateName));
        
        if (withMain) builder.addMethod(generateMain(allVars, allAtts, name, bindings_schema));

        if (bindings_schema!=null) {
            builder.addMethod(generateFactoryMethod(allVars, allAtts, name, bindings_schema));
            builder.addMethod(generateFactoryMethodWithArray(allVars, allAtts, name, bindings_schema));
        }
        

       // System.out.println(allVars);
        
        TypeSpec bean=builder.build();
        
        JavaFile myfile = JavaFile.builder(packge, bean)
                .addFileComment("Generated Automatically by ProvToolbox for template $S",templateName)
                .build();

        return myfile;
    }
   
   public MethodSpec nameAccessorGenerator(String templateName) {


       MethodSpec.Builder builder = MethodSpec.methodBuilder("getName")
               .addModifiers(Modifier.PUBLIC)
               .addAnnotation(Override.class)

               .returns(String.class)
               .addStatement("return $S", templateName);
       return builder.build();
   }

 
       
   
   public MethodSpec generateTemplateGenerator(Set<QualifiedName> allVars, Set<QualifiedName> allAtts, Document doc, Hashtable<QualifiedName, String> vmap) {
              

       MethodSpec.Builder builder = MethodSpec.methodBuilder("generator")
               .addModifiers(Modifier.PUBLIC)
               .returns(Document.class)
               .addStatement("$T nullqn = null", QualifiedName.class)
               .addStatement("$T attrs=null", StatementGeneratorAction.cl_collectionOfAttributes)
               .addStatement("$T document = pf.newDocument()", Document.class)
 
       ;
       for (QualifiedName q: allVars) {
           builder.addParameter(QualifiedName.class, q.getLocalPart());
       }
       for (QualifiedName q: allAtts) {
           if (allVars.contains(q)) {
               // no need to redeclare
           } else {
               builder.addParameter(Object.class, q.getLocalPart()); // without type declaration, any object may be accepted, assuming this is not a q also in allVars.
           }
       }
       for (QualifiedName q: allVars) {
           if (ExpandUtil.isGensymVariable(q)) {
               final String vgen = q.getLocalPart();
               builder.addStatement("if ($N==null) $N=org.openprovenance.prov.template.ExpandAction.getUUIDQualifiedName2(pf)",vgen,vgen);
           }
       }

       
       StatementGeneratorAction action=new StatementGeneratorAction(pFactory, allVars, allAtts, vmap, builder, "document.getStatementOrBundle()");
       for (StatementOrBundle s: doc.getStatementOrBundle()) {
           u.doAction(s, action);
           
       }
       builder.addStatement("new $T().updateNamespaces(document)", ProvUtilities.class);

       builder.addStatement("return document");

       MethodSpec method=builder.build();
       
       return method;
   }
   
   public Hashtable<QualifiedName, String> generateQualifiedNames(Document doc, Builder builder) {
       Bundle bun=u.getBundle(doc).get(0);
       Set<QualifiedName> set=new HashSet<QualifiedName>();
       gu.allQualifiedNames(bun,set,pFactory);
       set.remove(pFactory.newQualifiedName(ExpandUtil.TMPL_NS,ExpandUtil.LABEL,ExpandUtil.TMPL_PREFIX));
       set.add(pFactory.getName().PROV_LABEL);
       Hashtable<QualifiedName,String> qnVariables=new Hashtable<QualifiedName, String>();
       for (QualifiedName qn: set) {
           if (!(ExpandUtil.isVariable(qn))) {
               final String v = variableForQualifiedName(qn);
               qnVariables.put(qn,v);

               builder.addField(QualifiedName.class,v, Modifier.PUBLIC, Modifier.FINAL);
           }

           
       }
       return qnVariables;

   }


   public String variableForQualifiedName(QualifiedName qn) {
       return "_Q_" + qn.getPrefix() + "_" + qn.getLocalPart();
   }

   public MethodSpec generateFactoryMethod(Set<QualifiedName> allVars, Set<QualifiedName> allAtts, String name, JsonNode bindings_schema) {
       MethodSpec.Builder builder = MethodSpec.methodBuilder("make")
               .addModifiers(Modifier.PUBLIC)
               .returns(Document.class)
               .addStatement("$T document = null", Document.class)
               .addStatement("$T ns = new Namespace()", Namespace.class)
  
               ;
       
       JsonNode the_var=bindings_schema.get("var");
       JsonNode the_context=bindings_schema.get("context");

       Iterator<String> iter=the_var.fieldNames();
       while(iter.hasNext()){
           String key=iter.next();
           builder.addParameter(getDeclaredType(the_var, key), key); 
       }
       
       Iterator<String> iter2=the_context.fieldNames();
       while(iter2.hasNext()){
           String prefix=iter2.next();
           String uri=the_context.get(prefix).textValue();
           builder.addStatement("ns.register($S,$S)", prefix, uri);  // TODO: needs substitution here, to expand the URI potentially containing * 
       }
           
       
       String args="";
       boolean first=true;
       for (QualifiedName q: allVars) {
           final String key = q.getLocalPart();
           final String newName = "__"+key;
           final JsonNode entry = the_var.path(key);
           if (entry!=null && !(entry instanceof MissingNode)) {
               String s=entry.get(0).get("@id").textValue();
               String s2="\"" + s.replace("*","\" + $N + \"") + "\"";
               builder.addStatement("$T $N=($N==null)?null:ns.stringToQualifiedName(" + s2 + ",pf)", QualifiedName.class, newName, key,key);
           } else {
               // TODO: check if it was a gensym, because then i can generate it!
               builder.addStatement("$T $N=null", QualifiedName.class, newName);
           }
           if (first) {
               first=false;
               args=newName;
           } else {
               args=args + ", " + newName; 
           }
       }
       
       for (QualifiedName q: allAtts) {
           final String key = q.getLocalPart();
           if (first) {
               first=false;
               args=key;
           } else {
               args=args + ", " + key; 
           }
       }
       
       builder.addStatement("document = generator(" + args + ")");

                      
       builder.addStatement("return document");

 
       
       MethodSpec method=builder.build();
       
       return method;
   }

   public MethodSpec generateFactoryMethodWithArray(Set<QualifiedName> allVars, Set<QualifiedName> allAtts, String name, JsonNode bindings_schema) {
       MethodSpec.Builder builder = MethodSpec.methodBuilder("make")
               .addModifiers(Modifier.PUBLIC)
               .returns(Document.class)
  
               ;
       
       JsonNode the_var=bindings_schema.get("var");
       JsonNode the_context=bindings_schema.get("context");
       
       builder.addParameter(Object[].class,"record");

       int count=1;
       Iterator<String> iter=the_var.fieldNames();
       String args="";
       while(iter.hasNext()){
           String key=iter.next();
           final Class<?> atype = getDeclaredType(the_var, key);
           String statement="$T $N=($T)record[" + count + "]";
           builder.addStatement(statement, atype, key,atype); 
           if (count > 1) args=args + ", ";
           args=args+key;
           count++;
       }
       builder.addStatement("return make(" + args + ")");  

      
                      

 
       
       MethodSpec method=builder.build();
       
       return method;
   }

   public Class<?> getDeclaredType(JsonNode the_var, String key) {
       if (the_var.get(key).get(0).get("@id")!=null) {
           return String.class;
       } else {
           if (the_var.get(key).get(0).get(0)==null) {
               System.out.println("key is " + key);
               System.out.println("decl is " + the_var);

               throw new UnsupportedOperationException();
           }
           JsonNode hasType=the_var.get(key).get(0).get(0).get("@type");
           if (hasType!=null) {
               String keyType=hasType.textValue();
               switch (keyType) {
                 case "xsd:int":
                   return Integer.class;
                 case "xsd:string":
                   return String.class;
                 case "xsd:boolean":
                     return Boolean.class;
                 default:
                   throw new UnsupportedOperationException();
               }
           } else {
               System.out.println("key is " + key);
               System.out.println("decl is " + the_var);

               throw new UnsupportedOperationException();
           }
       }
   }
   
   public MethodSpec generateMain(Set<QualifiedName> allVars, Set<QualifiedName> allAtts, String name, JsonNode bindings_schema) {

       MethodSpec.Builder builder = MethodSpec.methodBuilder("main")
               .addModifiers(Modifier.PUBLIC, Modifier.STATIC)
               .returns(void.class)
               .addParameter(String[].class, "args")
               .addStatement("$T pf=org.openprovenance.prov.xml.ProvFactory.getFactory()",ProvFactory.class)
               .addStatement("$N me=new $N(pf)",name,name);

       ;
       for (QualifiedName q: allVars) {
           builder.addStatement("$T $N=pf.newQualifiedName($S,$S,$S)", QualifiedName.class, q.getLocalPart(), "http://example.org/",q.getLocalPart(), "ex");
       }
       for (QualifiedName q: allAtts) {
           builder.addStatement("$T $N=$S", String.class, q.getLocalPart(), "test_" + q.getLocalPart());
       }
       
       String args="";
       boolean first=true;
       for (QualifiedName q: allVars) {
           if (first) {
               first=false;
               args=q.getLocalPart();
           } else {
               args=args + ", " + q.getLocalPart();
           } 
       }
       for (QualifiedName q: allAtts) {
           final String key = q.getLocalPart();
           if (first) {
               first=false;
               args=key;
           } else {
               args=args + ", " + key; 
           }
       }
       
       builder.addStatement("$T document=me.generator(" + args + ")", Document.class);
       
       builder.addStatement("new org.openprovenance.prov.interop.InteropFramework().writeDocument(System.out,org.openprovenance.prov.interop.InteropFramework.ProvFormat.PROVN,document)"); //TODO make it load dynamically
            

       if (bindings_schema!=null) {
           JsonNode the_var=bindings_schema.get("var");

           Iterator<String> iter=the_var.fieldNames();
           args="";
           first=true;
           int count=0;
           while(iter.hasNext()){
               String key=iter.next();
               if (first) {
                   first=false;
                   args=createExamplar(the_var,key,count++);
               } else {
                   args=args + ", " +  createExamplar(the_var,key,count++);
               }
           }
           
           builder.addStatement("document=me.make(" + args + ")");
           builder.addStatement("new org.openprovenance.prov.interop.InteropFramework().writeDocument(System.out,org.openprovenance.prov.interop.InteropFramework.ProvFormat.PROVN,document)");

           
       }
       
       
       MethodSpec method=builder.build();
       
       return method;
   }

   public String createExamplar(JsonNode the_var, String key, int num) {
       if (the_var.get(key).get(0).get("@id")!=null) {
           return "\"v" + num + "\"";
       } else {
           if (the_var.get(key).get(0).get(0)==null) {
               System.out.println("key is " + key);
               System.out.println("decl is " + the_var);

               throw new UnsupportedOperationException();
           }
           JsonNode hasType=the_var.get(key).get(0).get(0).get("@type");
           if (hasType!=null) {
               String keyType=hasType.textValue();
               switch (keyType) {
                 case "xsd:int":
                   return "" + num;
                 case "xsd:string":
                   return "\"v" + num + "\"";
                 case "xsd:boolean":
                   return "true";
                 default:
                   throw new UnsupportedOperationException();
               }
           } else {
               System.out.println("key is " + key);
               System.out.println("decl is " + the_var);

               throw new UnsupportedOperationException();
           }
       }
   }

}
