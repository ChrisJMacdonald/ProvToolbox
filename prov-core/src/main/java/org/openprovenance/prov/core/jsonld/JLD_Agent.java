package org.openprovenance.prov.core.jsonld;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.xml.datatype.XMLGregorianCalendar;

@JsonPropertyOrder({ "@id" })
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public interface JLD_Agent extends JLD_Generic {



}
