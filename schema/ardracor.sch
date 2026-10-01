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
        <!-- TEI body checks -->
        <!-- checks of @who attributes: do they point to ids that are defined in the list of characters in the TEI header? -->
        <sch:let name="ids-cast-list" value="//tei:particDesc//tei:person/@xml:id"/>
        <sch:rule context="tei:sp">
          <sch:assert test="every $w in tokenize(@who,'\s') satisfies (substring-after($w,'#') = $ids-cast-list)">Error: the value of @who should be one of the @xml:id values in the cast list.</sch:assert>
        </sch:rule>
        <!-- checks of language codes -->
        <sch:rule context="tei:foreign">
          <sch:let name="lang-list" value="('es','la','it','en','coc','grc')"/>
          <!-- grc: Ancient Greek
          coc: Cocoliche -->
          <sch:assert test="@xml:lang = $lang-list">Error: the attribute @xml:lang of a foreign element should have one of the following values: <sch:value-of select="$lang-list"/>.</sch:assert>
        </sch:rule>
        <sch:rule context="tei:stage[ancestor::tei:sp][ancestor::tei:l or ancestor::tei:p]">
          <sch:assert test="@type='inline'">Error: a stage direction inside a verse line or spoken paragraph should have an attribute @type with the value 'inline'.</sch:assert>
        </sch:rule>
        <sch:rule context="tei:emph">
          <sch:assert test="@rend[tokenize(.,'\s') = ('italic','bold')]">Error: every &lt;emph&gt; element should have a @rend attribute with the values 'italic' or 'bold' or both, separated by whitespace.</sch:assert>
        </sch:rule>
        <sch:rule context="tei:trailer">
          <sch:assert test="ancestor::tei:back">Error: the element &lt;trailer&gt; should appear in the back, not the body.</sch:assert>
        </sch:rule>
    </sch:pattern>
  
        
</sch:schema>
