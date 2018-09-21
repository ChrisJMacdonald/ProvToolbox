package org.openprovenance.prov.template;

import com.fasterxml.jackson.annotation.JsonProperty;

public class GeneratorConfig {
    // provconvert -infile templates/grow.provn -template grow -builder -package foo -bindings bindings/grow_bs.json -bindver 3 -outfile src/main/java
    public String name;
    public String template;
    @JsonProperty("package")
    public String package_;
    public String bindings;
    public String destination;
   
    @Override
    public String toString() {
        return "GeneratorConfig [name=" + name + ", template=" + template + ", package=" + package_
                + ", bindings=" + bindings + ", destination=" + destination + "]";
    }
    

}