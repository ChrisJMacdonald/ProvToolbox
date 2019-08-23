package org.openprovenance.prov.core;

import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.openprovenance.apache.commons.lang.builder.*;
import org.openprovenance.prov.core.serialization.CustomAttributesSerializer;
import org.openprovenance.prov.core.serialization.CustomKeyDeserializer;
import org.openprovenance.prov.core.serialization.CustomMapSerializer;
import org.openprovenance.prov.core.serialization.CustomQualifiedNameDeserializer;
import org.openprovenance.prov.model.Attribute;
import org.openprovenance.prov.model.QualifiedName;

import javax.xml.datatype.XMLGregorianCalendar;
import java.util.*;
import java.util.stream.Collectors;

@JsonPropertyOrder({ "@id" })

public class Entity implements org.openprovenance.prov.model.Entity, Equals, HashCode, ToString, HasAttributes {

    private final QualifiedName QUALIFIED_NAME_XSD_STRING = ProvFactory.getFactory().getName().XSD_STRING;
    private Optional<QualifiedName> id;

    private List<org.openprovenance.prov.model.LangString> labels = new LinkedList<>();
    private List<org.openprovenance.prov.model.Location> location = new LinkedList<>();
    private List<org.openprovenance.prov.model.Other> other = new LinkedList<>();
    private List<org.openprovenance.prov.model.Type> type = new LinkedList<>();
    private org.openprovenance.prov.model.Value value;


    final ProvUtilities u=new ProvUtilities();



    private Entity() {}

    public Entity(QualifiedName id,
                  Collection<Attribute> attributes) {
        this.setId(id);


        u.populateAttributes(attributes, location, type);


    }

    public void setValue(org.openprovenance.prov.model.Value o) {

    }

    public org.openprovenance.prov.model.Value getValue() {
        return null;
    }



    @JsonDeserialize(using = CustomQualifiedNameDeserializer.class)
    @JsonProperty("@id")
    @Override
    public QualifiedName getId() {
        return id.orElse(null);
    }


    @JsonIgnore
    @Override
    public Kind getKind() {
        return Kind.PROV_ENTITY;
    }



    @JsonProperty("@id")
    @Override
    public void setId(QualifiedName value) {
        id = Optional.ofNullable(value);
    }



    @JsonIgnore
    @Override
    public List<org.openprovenance.prov.model.LangString> getLabel() {
        return labels;
    }

    @JsonIgnore
    @Override
    public List<org.openprovenance.prov.model.Location> getLocation() {
        return location;
    }

    @JsonIgnore
    @Override
    public List<org.openprovenance.prov.model.Type> getType() {
        return type;
    }


    @JsonIgnore
    @Override
    public List<org.openprovenance.prov.model.Other> getOther() {
        return other;
    }



    public void equals(Object object, EqualsBuilder equalsBuilder) {
        if (!(object instanceof Entity)) {
            equalsBuilder.appendSuper(false);
            return ;
        }
        if (this == object) {
            return ;
        }
        final Entity that = ((Entity) object);
        equalsBuilder.append(this.getId(), that.getId());
       equalsBuilder.append(this.getIndexedAttributes(), that.getIndexedAttributes());
    }

    public boolean equals(Object object) {
        if (!(object instanceof Entity)) {
            return false;
        }
        if (this == object) {
            return true;
        }
        final EqualsBuilder equalsBuilder = new EqualsBuilder();
        equals(object, equalsBuilder);
        return equalsBuilder.isEquals();
    }

    public void hashCode(HashCodeBuilder hashCodeBuilder) {
        hashCodeBuilder.append(this.getId());
        hashCodeBuilder.append(this.getIndexedAttributes());
    }

    public int hashCode() {
        final HashCodeBuilder hashCodeBuilder = new HashCodeBuilder();
        hashCode(hashCodeBuilder);
        return hashCodeBuilder.toHashCode();
    }

    public void toString(ToStringBuilder toStringBuilder) {

        {
            Map<QualifiedName, Set<Attribute>> theAttributes;
            theAttributes = this.getIndexedAttributes();
            toStringBuilder.append("attributes", theAttributes);
        }


        {
            QualifiedName theId;
            theId = this.getId();
            toStringBuilder.append("id", theId);
        }
    }

    @Override
    public String toString() {
        final ToStringBuilder toStringBuilder = new ToStringBuilder(this);
        toString(toStringBuilder);
        return toStringBuilder.toString();
    }

    @JsonIgnore
    @Override
    public Collection<Attribute> getAttributes() {
        LinkedList<Attribute> result=new LinkedList<>();
        result.addAll(getLabel().stream().map(s -> new Label(QUALIFIED_NAME_XSD_STRING,s)).collect(Collectors.toList()));
        result.addAll(getType());
        result.addAll(getLocation());
        result.addAll(getOther().stream().map(o -> (Attribute)o).collect(Collectors.toList())); //TODO: collect directly into result
        return result;
    }

    @JsonAnySetter
    @JsonDeserialize(keyUsing= CustomKeyDeserializer.class)
    public void setIndexedAttributes (Object qn, Set<Attribute> attributes) {
        u.distribute((QualifiedName)qn,attributes,getLabel(),getLocation(),getType(),getOther());
    }


    @JsonAnyGetter
    @Override
    @JsonProperty("attributes")
    @JsonSerialize(keyUsing= CustomMapSerializer.class, contentUsing = CustomAttributesSerializer.class)
    public Map<QualifiedName, Set<Attribute>> getIndexedAttributes() {
        return u.split(getAttributes());
    }


}