package org.openprovenance.prov.sql;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.openprovenance.prov.model.DOMProcessing;
import org.openprovenance.prov.model.Name;
import javax.xml.namespace.QName;

import org.jvnet.jaxb2_commons.lang.Equals;
import org.jvnet.jaxb2_commons.lang.EqualsStrategy;
import org.jvnet.jaxb2_commons.lang.HashCode;
import org.jvnet.jaxb2_commons.lang.HashCodeStrategy;
import org.jvnet.jaxb2_commons.lang.JAXBEqualsStrategy;
import org.jvnet.jaxb2_commons.lang.JAXBHashCodeStrategy;
import org.jvnet.jaxb2_commons.locator.ObjectLocator;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Key", namespace = "http://www.w3.org/ns/prov#")
//@XmlJavaTypeAdapter(LocationAdapter.class)
@javax.persistence.Entity(name = "Key")
@Table(name = "KEY")
// @Inheritance(strategy = InheritanceType.JOINED)
public class Key extends TypedValue implements Equals, HashCode, org.openprovenance.prov.model.Key,
	org.openprovenance.prov.model.Attribute {

    private static final AttributeKind PROV_KEY_KIND = org.openprovenance.prov.model.Attribute.AttributeKind.PROV_KEY;
    private static final QName PROV_KEY_QNAME = Name.PROV_KEY_QNAME;

    @Transient
    public QName getElementName() {
	return PROV_KEY_QNAME;
    }
    
    @Transient
    public AttributeKind getKind() {
	return PROV_KEY_KIND;
    }
    

    public String toNotationString() {
	return DOMProcessing.qnameToString(getElementName()) + " = "
		+ org.openprovenance.prov.xml.Helper.valueToNotationString(getValue(), getType());
    }
    


    public boolean equals(ObjectLocator thisLocator, ObjectLocator thatLocator, Object object, EqualsStrategy strategy) {
        if (!(object instanceof Key)) {
            return false;
        }
        if (this == object) {
            return true;
        }
        if (!super.equals(thisLocator, thatLocator, object, strategy)) {
            return false;
        }
        return true;
    }

    public boolean equals(Object object) {
        final EqualsStrategy strategy = JAXBEqualsStrategy.INSTANCE;
        return equals(null, null, object, strategy);
    }

    public int hashCode(ObjectLocator locator, HashCodeStrategy strategy) {
        int currentHashCode = super.hashCode(locator, strategy);
        return currentHashCode;
    }

    public int hashCode() {
        final HashCodeStrategy strategy = JAXBHashCodeStrategy.INSTANCE;
        return this.hashCode(null, strategy);
    }


}