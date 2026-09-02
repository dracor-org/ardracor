<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    
    <sch:title>ArDraCor Schematron file</sch:title>
    
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    
    <sch:pattern>
        <!-- basic TEI checks -->
        <sch:rule context="tei:TEI">
            <sch:assert test="@xml:id[matches(.,'^ar\d{6}$')]">Error: the TEI element should carry an @xml:id beginning with the letters "ar", followed by six digits, e.g., "ar000001".</sch:assert>
        </sch:rule>
        <!-- TEI header checks -->
        <sch:rule context="tei:publicationStmt">
            <sch:assert test="tei:publisher[@xml:id = 'dracor']">Error: there should be a publisher element with an ID "dracor".</sch:assert>
            <sch:assert test="tei:publisher[@xml:id = 'hdlab']">Error: there should be a publisher element with an ID "hdlab".</sch:assert>
            <sch:assert test="tei:publisher[@xml:id = 'rosDH']">Error: there should be a publisher element with an ID "rosDH".</sch:assert>
        </sch:rule>
        <sch:rule context="tei:profileDesc">
            <sch:assert test="tei:particDesc/tei:listPerson">Error: there should be a participant list with a person list containing the names of the characters in the play.</sch:assert>
        </sch:rule>
        <sch:rule context="tei:particDesc//tei:person">
            <sch:assert test="@sex = ('MALE','FEMALE','UNKNOWN')">Error: the attribute @sex of a person should have one of the following values: MALE, FEMALE, UNKNOWN.</sch:assert>
        </sch:rule>
        <!-- checks of @who attributes -->
        <sch:let name="ids-cast-list" value="//tei:particDesc//tei:person/@xml:id"/>
        <sch:rule context="tei:sp">
          <sch:assert test="every $w in tokenize(@who,'\s') satisfies (substring-after($w,'#') = $ids-cast-list)">Error: the value of @who should be one of the @xml:id values in the cast list.</sch:assert>
        </sch:rule>
    </sch:pattern>
        
</sch:schema>
