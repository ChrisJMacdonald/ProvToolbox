package org.openprovenance.prov.core.xml.serialization.deserial;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;
import org.openprovenance.prov.core.vanilla.LangString;
import org.openprovenance.prov.core.vanilla.ProvFactory;
import org.openprovenance.prov.core.xml.serialization.Constants;
import org.openprovenance.prov.core.xml.serialization.ProvSerialiser;
import org.openprovenance.prov.core.xml.serialization.serial.CustomTypedValueSerializer;
import org.openprovenance.prov.core.xml.serialization.ProvDeserialiser;
import org.openprovenance.prov.model.Attribute;
import org.openprovenance.prov.model.Namespace;
import org.openprovenance.prov.model.QualifiedName;
import org.openprovenance.prov.model.QualifiedNameUtils;

import java.io.IOException;
import java.util.Map;

public class CustomAttributeDeserializerWithRootName extends StdDeserializer<Attribute> implements Constants {


    private static final ProvFactory pf= ProvDeserialiser.pf;

    public CustomAttributeDeserializerWithRootName() {
        this(Attribute.class);
    }


    public CustomAttributeDeserializerWithRootName(Class<?> vc) {
        super(vc);
    }

    @Override
    public Attribute deserialize(JsonParser jp, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
        JsonNode node = jp.getCodec().readTree(jp);

        return deserialize(node, deserializationContext);


    }

    public Attribute deserialize(JsonNode node, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
        Namespace ns= (Namespace) deserializationContext.getAttribute(CustomNamespaceDeserializer.CONTEXT_KEY_NAMESPACE);
        Map.Entry<String, JsonNode> pair=node.fields().next();

        QualifiedName elementName=ns.stringToQualifiedName(pair.getKey(),pf);
        elementName=unescapeQualifiedName(elementName);


        JsonNode vObj=pair.getValue();

        return deserialize(elementName,vObj,deserializationContext);

    }

    public Attribute deserialize(QualifiedName elementName,  String astring, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
        Namespace ns= (Namespace) deserializationContext.getAttribute(CustomNamespaceDeserializer.CONTEXT_KEY_NAMESPACE);

        return pf.newAttribute(elementName, new LangString(astring,null), ProvSerialiser.QUALIFIED_NAME_XSD_STRING);
    }





    public Attribute deserialize(QualifiedName elementName, JsonNode vObj, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
        Namespace ns= (Namespace) deserializationContext.getAttribute(CustomNamespaceDeserializer.CONTEXT_KEY_NAMESPACE);


        JsonNode typeRaw = vObj.get(PROPERTY_AT_TYPE);
        String type = (typeRaw == null) ? null : typeRaw.textValue();

        JsonNode value = vObj.get(PROPERTY_AT_VALUE);


        Object valueObject=value.textValue(); //TODO: should not be checking qname but uri
        if ((type.equals("xsd:string") || type.equals("prov:InternationalizedString")) && value.isObject()) {
            JsonNode theValue=value.get(Constants.PROPERTY_STRING_VALUE);
            JsonNode theLang=value.get(Constants.PROPERTY_STRING_LANG);
            valueObject=new LangString(theValue.textValue(),(theLang==null)?null:theLang.textValue());
        } else if (type.equals("xsd:QName")) {
            valueObject=ns.stringToQualifiedName(value.textValue(),pf);
        }

        QualifiedName typeQN=ns.stringToQualifiedName(type,pf);
        return pf.newAttribute(elementName,valueObject, typeQN);
    }

    final static QualifiedNameUtils qnU=new QualifiedNameUtils();

    static public QualifiedName unescapeQualifiedName(QualifiedName id) {

        String namespace=id.getNamespaceURI();
        String local=qnU.escapeProvLocalName(qnU.unescapeFromXsdLocalName(id.getLocalPart()));
        String prefix=id.getPrefix();
        return pf.newQualifiedName(namespace,local,prefix);
    }

    public Attribute deserializeX(QualifiedName elementName, String type, String lang, String body, DeserializationContext deserializationContext) {
        Namespace ns= (Namespace) deserializationContext.getAttribute(CustomNamespaceDeserializer.CONTEXT_KEY_NAMESPACE);

        QualifiedName unescaped=unescapeQualifiedName(elementName);
        Object valueObject=body;
        if (type==null || type.equals("xsd:string") || type.equals("prov:InternationalizedString")) {
            valueObject=new LangString(body,lang);
            if (type==null) {
                type="xsd:string";
            }
        } else if (type.equals("xsd:QName")) {
            valueObject=ns.stringToQualifiedName(body,pf);
            type="prov:QUALIFIED_NAME";
        }
        Attribute attr= pf.newAttribute(unescaped,valueObject, ns.stringToQualifiedName(type,pf));

        return attr;

    }
}