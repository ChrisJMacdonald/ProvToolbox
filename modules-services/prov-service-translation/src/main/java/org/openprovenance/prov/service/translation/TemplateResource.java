package org.openprovenance.prov.service.translation;

import org.openprovenance.prov.service.core.DocumentResource;
import org.openprovenance.prov.template.expander.Bindings;

/* A PROV document generated by template expansion with some bindings. */
public interface TemplateResource extends DocumentResource, Cloneable{
     String TEMPLATE = "TEMPLATE";
     static String getResourceKind() {
          return TEMPLATE;
     }

     String getBindingsStorageId() ;

     void setBindingsStorageId(String bindingsStorageId);

     String getTemplateStorageId();

     void setTemplateStorageId(String templateStorageId);
}
