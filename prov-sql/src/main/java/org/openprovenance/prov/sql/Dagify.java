package org.openprovenance.prov.sql;

import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.openprovenance.prov.model.DerivedByInsertionFrom;
import org.openprovenance.prov.model.DerivedByRemovalFrom;
import org.openprovenance.prov.model.DictionaryMembership;
import org.openprovenance.prov.model.NamedBundle;
import org.openprovenance.prov.model.ProvUtilities;
import org.openprovenance.prov.model.QualifiedName;
import org.openprovenance.prov.model.StatementAction;




public class Dagify implements StatementAction {

    private EntityManager em;

    public Dagify(EntityManager em) {
        this.em=em;
    }
    
    Hashtable<String, QualifiedName> table=new Hashtable<String, QualifiedName>();
    


    public QualifiedName uniquify(QualifiedName q) {
        if (q==null) return null;
        String uri=q.getNamespaceURI()+q.getLocalPart();
        org.openprovenance.prov.model.QualifiedName found=table.get(uri);
        if (found!=null) {
            return found;
        }
        Query qq=em.createQuery("SELECT e FROM QualifiedName e WHERE e.uri LIKE :uri");
        qq.setParameter("uri", uri);
        @SuppressWarnings("unchecked")
	List<QualifiedName> ll=(List<QualifiedName>) qq.getResultList();
        //System.out.println("found ll " + ll);
        
        QualifiedName newId=q;
        if ((ll!=null) && (!(ll.isEmpty()))) {
            newId=ll.get(0);
            //System.out.println("Uniquify found " + newId);
        }
        table.put(uri, newId);
        return newId;
    }

   


    public void doAction(org.openprovenance.prov.model.Entity e) {
    	e.setId(uniquify(e.getId()));
    }

    
    public void doAction(org.openprovenance.prov.model.Activity a) {
	a.setId(uniquify(a.getId()));        
    }

  




    public void doAction(org.openprovenance.prov.model.Agent ag) {
	ag.setId(uniquify(ag.getId()));                
    }

    public void doAction(org.openprovenance.prov.model.WasGeneratedBy gen) {
    	if (gen.getId()!=null) gen.setId(uniquify(gen.getId()));                
    	gen.setEntity(uniquify(gen.getEntity()));
        gen.setActivity(uniquify(gen.getActivity()));
    }

    public void doAction(org.openprovenance.prov.model.Used use) {
	if (use.getId()!=null) use.setId(uniquify(use.getId()));                
        use.setEntity(uniquify(use.getEntity()));
        use.setActivity(uniquify(use.getActivity()));      
    }

    public void doAction(org.openprovenance.prov.model.WasInvalidatedBy inv) {
	if (inv.getId()!=null) inv.setId(uniquify(inv.getId()));                
        inv.setEntity(uniquify(inv.getEntity()));
        inv.setActivity(uniquify(inv.getActivity()));          
    }

    public void doAction(org.openprovenance.prov.model.WasStartedBy start) {
	if (start.getId()!=null) start.setId(uniquify(start.getId()));                
        start.setActivity(uniquify(start.getActivity()));    
        start.setTrigger(uniquify(start.getTrigger()));
        start.setStarter(uniquify(start.getStarter()));                  
    }

    public void doAction(org.openprovenance.prov.model.WasEndedBy end) {
	if (end.getId()!=null) end.setId(uniquify(end.getId()));                
        end.setActivity(uniquify(end.getActivity()));    
        end.setTrigger(uniquify(end.getTrigger()));
        end.setEnder(uniquify(end.getEnder()));          
      
    }

    public void doAction(org.openprovenance.prov.model.WasInformedBy inf) {
	if (inf.getId()!=null) inf.setId(uniquify(inf.getId()));                
        inf.setInformant(uniquify(inf.getInformant()));    
        inf.setInformed(uniquify(inf.getInformed()));    
    }

    public void doAction(org.openprovenance.prov.model.WasDerivedFrom der) {
	if (der.getId()!=null) der.setId(uniquify(der.getId()));                
        der.setGeneratedEntity(uniquify(der.getGeneratedEntity()));    
        der.setUsedEntity(uniquify(der.getUsedEntity()));    
        der.setActivity(uniquify(der.getActivity()));    
        der.setGeneration(uniquify(der.getGeneration()));    
        der.setUsage(uniquify(der.getUsage()));           
    }

    public void doAction(org.openprovenance.prov.model.WasAssociatedWith assoc) {
	if (assoc.getId()!=null) assoc.setId(uniquify(assoc.getId()));                
        assoc.setActivity(uniquify(assoc.getActivity()));    
        assoc.setAgent(uniquify(assoc.getAgent()));    
        assoc.setPlan(uniquify(assoc.getPlan()));    
    }

    public void doAction(org.openprovenance.prov.model.WasAttributedTo attr) {
	if (attr.getId()!=null) attr.setId(uniquify(attr.getId()));                
        attr.setAgent(uniquify(attr.getAgent()));    
        attr.setEntity(uniquify(attr.getEntity()));
    }

    public void doAction(org.openprovenance.prov.model.ActedOnBehalfOf del) {
	if (del.getId()!=null) del.setId(uniquify(del.getId()));                
        del.setDelegate(uniquify(del.getDelegate()));    
        del.setResponsible(uniquify(del.getResponsible()));    
        del.setActivity(uniquify(del.getActivity()));            
    }

    public void doAction(org.openprovenance.prov.model.WasInfluencedBy inf) {
	if (inf.getId()!=null) inf.setId(uniquify(inf.getId()));                
        inf.setInfluencee(uniquify(inf.getInfluencee()));
        inf.setInfluencer(uniquify(inf.getInfluencer()));
    }

    public void doAction(org.openprovenance.prov.model.AlternateOf alt) {
        alt.setAlternate1(uniquify(alt.getAlternate1()));
        alt.setAlternate2(uniquify(alt.getAlternate2()));
    }

    public void doAction(org.openprovenance.prov.model.MentionOf men) {
        men.setBundle(uniquify(men.getBundle()));
        men.setGeneralEntity(uniquify(men.getGeneralEntity()));
        men.setSpecificEntity(uniquify(men.getSpecificEntity()));       
    }

    public void doAction(org.openprovenance.prov.model.SpecializationOf spec) {
        spec.setSpecificEntity(uniquify(spec.getSpecificEntity()));
        spec.setGeneralEntity(uniquify(spec.getGeneralEntity()));
    }

    public void doAction(org.openprovenance.prov.model.HadMember mem) {
        List<org.openprovenance.prov.model.QualifiedName> ll=new LinkedList<org.openprovenance.prov.model.QualifiedName>();
        for (org.openprovenance.prov.model.QualifiedName er: mem.getEntity()) {
            ll.add(uniquify(er));
        }
        mem.getEntity().clear();
        mem.getEntity().addAll(ll);
        
        mem.setCollection(uniquify(mem.getCollection()));        
    }
  

    @Override
    public void doAction(DictionaryMembership s) {
	throw new UnsupportedOperationException();
    }


    @Override
    public void doAction(DerivedByRemovalFrom s) {
	throw new UnsupportedOperationException();
    }


    @Override
    public void doAction(DerivedByInsertionFrom s) {
	throw new UnsupportedOperationException();	
    }




    @Override
    public void doAction(NamedBundle bun, ProvUtilities provUtilities) {
	bun.setId(uniquify(bun.getId()));
	provUtilities.forAllStatement(bun.getStatement(), this);
    }

}