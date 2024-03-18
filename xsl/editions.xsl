<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    <xsl:output encoding="UTF-8" media-type="text/xml" method="xml" indent="yes" omit-xml-declaration="yes"/>
    
    <!-- <xsl:template match="/">
        <xsl:variable name="file" select="substring-after(//tei:titleStmt/tei:title[@type]/text(), 'Wiener Zeitung ')"/>
        <xsl:result-document href="{$file}.xml" method="xml">
            <xsl:text disable-output-escaping='yes'>&lt;?xml version="1.0" encoding="UTF-8"?&gt;</xsl:text>
            <xsl:copy>
                <xsl:apply-templates select="node()|@*"/>
            </xsl:copy>
        </xsl:result-document>
    </xsl:template> -->
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:TEI">
        <xsl:variable name="file" select="substring-after(//tei:titleStmt/tei:title[not(@level)]/text(), 'Wiener Zeitung ')"/>
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="wr_{$file}.xml">
            <xsl:apply-templates select="node()|@*"/>
        </TEI>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader">
        <teiHeader>
            <xsl:apply-templates select="node()|@*"/>
            <encodingDesc>
                <projectDesc>
                    <p xml:id="m41">Siebenjähriger Krieg – Wienerisches Diarium Digital</p>
                    <p xml:id="m42">Created using Transkribus – WrDiarium_M9 model ID 47114</p>
                </projectDesc>
                <tagsDecl>
                    <rendition xml:id="f">Full width text, aligned left</rendition>
                    <rendition xml:id="fc">Full width text, centered</rendition>
                    <rendition xml:id="fh">Full width text, with hanging indent</rendition>
                    <rendition xml:id="fr">Full width text, aligned right</rendition>
                    <rendition xml:id="l">Text aligned left in a full width region</rendition>
                    <rendition xml:id="r">Text aligned right in a full width region</rendition>
                    <rendition xml:id="ll">Text aligned left (or justified) in a left column</rendition>
                    <rendition xml:id="lc">Text centered in a left column</rendition>
                    <rendition xml:id="lr">Text aligned right in a left column</rendition>
                    <rendition xml:id="lh">Text aligned left (or justified) in a left column with the first line hanging</rendition>
                    <rendition xml:id="rl">Text aligned left (or justified) in a right column</rendition>
                    <rendition xml:id="rc">Text centered in a right column</rendition>
                    <rendition xml:id="rr">Text aligned right in a right column</rendition>
                    <rendition xml:id="rh">Text aligned left (or justified) in a right column with the first line hanging</rendition>
                    <rendition xml:id="c">Text within the middle of a three column region, aligned left</rendition>
                    <rendition xml:id="cl">Text within the middle of a three column region, aligned left</rendition>
                    <rendition xml:id="cc">Text centered in a middle or centered column</rendition>
                    <rendition xml:id="cr">Text aligned right in a middle or centered column</rendition>
                    <rendition xml:id="ch">Text aligned left (or justified) in a middle or centered column with the first line hanging</rendition>
                </tagsDecl>
                <listPrefixDef>
                    <prefixDef ident="anno" matchPattern=".*(\d{3})(\d)(\d{2})(\d{2})-(\d+)\..*" replacementPattern="https://diarium-images.acdh-dev.oeaw.ac.at/$10/$1$2/$3/$1$2$3$4/$1$2$3$4-$5">
                        <p xml:id="p3">Ggf. nachbearbeitete ANNO-Bilder auf Diarium-IIIF</p>
                    </prefixDef>
                </listPrefixDef>
            </encodingDesc>
            <profileDesc>
                <langUsage>
                    <language ident="de-AT-Goth">18th century German as used in Austria (Vienna) in broken script</language>
                </langUsage>
                <textClass>
                    <keywords scheme="https://d-nb.info/gnd/">
                        <term ref="https://d-nb.info/gnd/4067510-5/about/lds.rdf">Zeitung</term>
                    </keywords>
                </textClass>
            </profileDesc>
            <revisionDesc status="draft">
                <change who="delsner" when="2024-01-22">Transformierung der Daten des Transkribus TEI-Export mit "editions.xsl".</change>
            </revisionDesc>
        </teiHeader>
    </xsl:template>
    
    <xsl:template match="tei:seriesStmt">
        <xsl:copy>
            <p>Maschinenlesbares Transkript von Wienerisches Diarium.</p>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:titleStmt">
        <xsl:copy>
            <title level="s" type="main">Wienerisches Diarium</title>
            <title level="s" type="sub">Digitale Edition</title>
            <!--<title level="a" type="main"><xsl:value-of select="//tei:titleStmt/tei:title[@type='main']"/></title>-->
            <title level="a" type="main"><xsl:value-of select="//tei:titleStmt/tei:title[@level='a']"/></title>
            <editor xml:id="nrastinger" ref="https://orcid.org/0000-0002-3235-5063">Rastinger, Nina</editor>
            <editor xml:id="cresch" ref="https://d-nb.info/gnd/132312794">Resch, Claudia</editor>
            <funder>Austrian Centre for Digital Humanities, Austrian Academy of Sciences</funder>
        </xsl:copy>
        <editionStmt>
            <edition>Siebenjähriger Krieg: Digitale Edition</edition>
            <respStmt>
                <resp>Herausgegeben von</resp>
                <name sameAs="nrastinger" ref="https://orcid.org/0000-0002-3235-5063">Rastinger, Nina</name>
                <name sameAs="cresch" ref="https://d-nb.info/gnd/132312794">Resch, Claudia</name>
            </respStmt>
            <respStmt>
                <resp>TEI Schema, ODD/RNG</resp>
                <name xml:id="delsner" ref="https://orcid.org/0000-0002-0636-4476">Elsner, Daniel</name>
                <name xml:id="cfhaak" ref="https://orcid.org/0009-0006-7740-542X">Haak, Carl Friedrich</name>                
            </respStmt>
        </editionStmt>
        <publicationStmt>
            <publisher>Austrian Centre for Digital Humanities, Austrian Academy of Sciences</publisher>
            <pubPlace>Vienna, Austria</pubPlace>
            <date when="2024">2024</date>
            <availability>
                <licence target="https://creativecommons.org/licenses/by/4.0">
                    <p>Sie dürfen: Teilen — das Material in jedwedem Format oder Medium
                        vervielfältigen und weiterverbreiten</p>
                    <p>Bearbeiten — das Material remixen, verändern und darauf aufbauen und zwar für
                        beliebige Zwecke, sogar kommerziell.</p>
                    <p>Der Lizenzgeber kann diese Freiheiten nicht widerrufen solange Sie sich an die
                        Lizenzbedingungen halten. Unter folgenden Bedingungen:</p>
                    <p>Namensnennung — Sie müssen angemessene Urheber- und Rechteangaben machen, einen
                        Link zur Lizenz beifügen und angeben, ob Änderungen vorgenommen wurden. Diese
                        Angaben dürfen in jeder angemessenen Art und Weise gemacht werden, allerdings
                        nicht so, dass der Eindruck entsteht, der Lizenzgeber unterstütze gerade Sie
                        oder Ihre Nutzung besonders.</p>
                    <p>Keine weiteren Einschränkungen — Sie dürfen keine zusätzlichen Klauseln oder
                        technische Verfahren einsetzen, die anderen rechtlich irgendetwas untersagen,
                        was die Lizenz erlaubt.</p>
                    <p>Hinweise:</p>
                    <p>Sie müssen sich nicht an diese Lizenz halten hinsichtlich solcher Teile des
                        Materials, die gemeinfrei sind, oder soweit Ihre Nutzungshandlungen durch
                        Ausnahmen und Schranken des Urheberrechts gedeckt sind.</p>
                    <p>Es werden keine Garantien gegeben und auch keine Gewähr geleistet. Die Lizenz
                        verschafft Ihnen möglicherweise nicht alle Erlaubnisse, die Sie für die
                        jeweilige Nutzung brauchen. Es können beispielsweise andere Rechte wie
                        Persönlichkeits- undDatenschutzrechte zu beachten sein, die Ihre Nutzung des
                        Materials entsprechend beschränken.</p>
                </licence>
            </availability>
        </publicationStmt>
    </xsl:template>

    <xsl:template match="tei:sourceDesc">
        <xsl:variable name="date" select="substring-after(./tei:bibl/tei:note, 'Wiener Zeitung ')"/>
        <xsl:copy>
            <biblStruct>
                <monogr>
                    <idno>
                        <xsl:attribute name="type">
                            <xsl:text>Transkribus</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="./tei:bibl/tei:idno[@type='Transkribus']"/>
                    </idno>
                    <idno>
                        <xsl:attribute name="type">
                            <xsl:text>ONB</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="./tei:bibl/tei:idno[@type='external']"/>
                    </idno>
                    <title>                     
                        <xsl:text>Wiener Zeitung</xsl:text> - <date type="published" when="{$date}"><xsl:value-of select="$date"/></date>
                    </title>
                    <imprint>
                        <publisher>Johann Peter van Ghelen</publisher>
                    </imprint>
                </monogr>
                <series>
                    <title>Wienerisches Diarium – <date when="{tokenize($date, '-')[1]}">Jahrgang <xsl:value-of select="tokenize($date, '-')[1]"/></date></title>
                </series>
                <series>
                    <title>Wiener Zeitung</title>
                </series>
            </biblStruct>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:text">
        <xsl:variable name="titlePage" select="./tei:body/tei:div[1]"/>
        <xsl:copy>
            <xsl:attribute name="cert">
                <xsl:value-of select="number(sum(//tei:word_conf/@conf)) div number(count(//tei:word_conf[@conf]))"/>
            </xsl:attribute>
            <xsl:attribute name="resp">
                <xsl:text>#m42</xsl:text>
            </xsl:attribute>
            <front>
                <titlePage>
                    <xsl:copy-of select="$titlePage/tei:pb"/>
                    <docTitle>
                        <titlePart>
                            <xsl:call-template name="num">
                                <xsl:with-param name="context" select="$titlePage"/>
                            </xsl:call-template>
                        </titlePart>
                        <titlePart type="main-title">
                            <xsl:call-template name="main-title"/>
                        </titlePart>
                    </docTitle>
                    <imprimatur>
                        <xsl:call-template name="imprint"/>
                    </imprimatur>
                    <milestone type="separator" rend="horizontal" unit="section" rendition="#f"/>
                </titlePage>
            </front>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:div[1][parent::tei:body]"/>
     
    <xsl:template match="tei:div[position() gt 1][parent::tei:body]">
        <xsl:copy>
            <xsl:attribute name="type" select="'article'"/>
            <xsl:attribute name="n" select="(position() div 2) - 1"/>
            <xsl:attribute name="xml:id" select="concat('a', (position() div 2) - 1)"/>
            <xsl:apply-templates select="node()|@*"/> 
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:principal"/>
    <xsl:template match="//tei:ab[@type='imprint' and contains(@facs, 'facs_1_')]"/>
    <xsl:template match="//tei:ab[@type='main-title' and contains(@facs, 'facs_1_')]"/>
    <xsl:template match="//tei:ab[@type='count-date' and contains(@facs, 'facs_1_')]"/>
    <xsl:template match="//tei:ab[@type='figure' and contains(@facs, 'facs_1_')]"/>
    
    <!-- <xsl:template match="tei:graphic">
        <xsl:variable name="base" select="replace(tokenize(base-uri(/), '/')[last()], '.xml', '_image_name.xml')"/>
        <xsl:variable name="items" select="doc(concat('../data/facs/', $base))"/>
        <xsl:variable name="pos" select="number(tokenize(parent::tei:surface/@xml:id, '_')[last()])"/>
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
            <xsl:attribute name="url">
                <xsl:value-of select="$items//item[$pos]"/>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template> -->
    
     <xsl:template match="tei:lb">
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="matches(string-join(./preceding::tei:*[1]//text(), ' '), '=$', 'm')">
                    <xsl:attribute name="break">
                        <xsl:text>no</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="position() = 1 and matches(string-join(parent::tei:p/preceding::tei:*[1]/tei:line_conf[last()]//text(), ' '), '=$', 'm')">
                    <xsl:attribute name="break">
                        <xsl:text>no</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="position() = 1 and matches(string-join(parent::tei:ab/preceding::tei:*[1]/tei:line_conf[last()]//text(), ' '), '=$', 'm')">
                    <xsl:attribute name="break">
                        <xsl:text>no</xsl:text>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="following-sibling::node()[1]/self::tei:line_conf[normalize-space()]">
                <xsl:apply-templates select="node()|@*"/>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="imprint">
        <xsl:for-each select="//tei:ab[@type='imprint' and contains(@facs, 'facs_1_')]">
            <xsl:attribute name="facs">
                <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:attribute name="rendition">
                <xsl:text>#f</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:text>tit1</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:ab[@type='imprint' and not(contains(@facs, 'facs_1_'))]">
        <xsl:copy>
            <xsl:attribute name="rendition">
                <xsl:text>#f</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:ab[@type='count-date' and not(contains(@facs, 'facs_1_'))]">
        <xsl:copy>
            <xsl:attribute name="rendition">
                <xsl:text>#f</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="num">
        <xsl:param name="context"/>
        <xsl:for-each select="$context/tei:ab[@type='count-date-normalized']">
            <xsl:attribute name="facs">
                <xsl:value-of select="$context/tei:ab[@type='count-date'][1]/@facs"/>
            </xsl:attribute>
            <xsl:attribute name="type">
                <xsl:text>num</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="rendition">
                <xsl:text>#f</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:text>imp1</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="main-title">
        <xsl:for-each select="//tei:ab[@type='main-title' and contains(@facs, 'facs_1_')]">
            <xsl:variable name="text" select="string-join(.//text(), ' ')"/>
            <xsl:attribute name="rendition">
                <xsl:text>#f</xsl:text>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="contains($text, 'Wienerisches') and contains($text, 'DIARIUM')">
                    <xsl:apply-templates select="node()|@*"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="count(child::tei:lb) = 1">
                            <lb facs="{./tei:lb[1]/@facs}" n="{./tei:lb[1]/@n}"/>Wienerisches DIARIUM
                        </xsl:when>
                        <xsl:otherwise>
                            <lb facs="{./tei:lb[1]/@facs}" n="{./tei:lb[1]/@n}"/>Wienerisches
                            <lb facs="{./tei:lb[2]/@facs}" n="{./tei:lb[2]/@n}"/>DIARIUM
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="text()[parent::tei:word_conf[ancestor::tei:body]]">
        <xsl:choose>
            <xsl:when test="matches(., '=$', 'm')">
                <xsl:value-of select="replace(., '=', '')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:head">
        <xsl:variable name="facs" select="substring-after(@facs, '#')"/>
        <xsl:variable name="zone" select="//id(data($facs))"/>
        <xsl:variable name="points" select="tokenize(tokenize($zone/@points, ' ')[1], ',')[1]"/>
        <xsl:variable name="x" select="number($points)"/>
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="$x gt 750">
                    <xsl:attribute name="rendition">
                        <xsl:text>#rc</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="rendition">
                        <xsl:text>#lc</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:p">
        <xsl:variable name="facs" select="substring-after(@facs, '#')"/>
        <xsl:variable name="zone" select="//id(data($facs))"/>
        <xsl:variable name="points" select="tokenize(tokenize($zone/@points, ' ')[1], ',')[1]"/>
        <xsl:variable name="x" select="number($points)"/>
        <xsl:copy>
            <xsl:if test="contains(preceding-sibling::tei:p[1]/tei:line_conf[last()]/tei:word_conf[last()]/text(), '.')">
                <xsl:attribute name="prev">
                    <xsl:text>true</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="contains(preceding-sibling::tei:*[1]/tei:line_conf[last()]/tei:word_conf[last()]/text(), '.')">
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="prev">
                        <xsl:text>true</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="$x gt 750">
                    <xsl:attribute name="rendition">
                        <xsl:text>#rc</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="rendition">
                        <xsl:text>#lc</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".[matches(preceding-sibling::tei:p[1]/text()[last()]/self::text(), '=$', 'm')]">
                    <xsl:attribute name="prev">
                        <xsl:text>true</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test=".[matches(preceding-sibling::tei:ab[1]/text()[last()]/self::text(), '=$', 'm')]">
                    <xsl:attribute name="prev">
                        <xsl:text>true</xsl:text>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:ab[@type='list']">
        <xsl:variable name="facs" select="substring-after(@facs, '#')"/>
        <xsl:variable name="zone" select="//id(data($facs))"/>
        <xsl:variable name="points" select="tokenize(tokenize($zone/@points, ' ')[1], ',')[1]"/>
        <xsl:variable name="x" select="number($points)"/>
        <list facs="{@facs}">
            <xsl:choose>
                <xsl:when test="$x gt 750">
                    <xsl:attribute name="rendition">
                        <xsl:text>#rc</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="rendition">
                        <xsl:text>#lc</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="node()|@*"/>
        </list>
    </xsl:template>

    <xsl:template match="tei:line_conf[parent::tei:ab[@type='list']]">
        <item cert="{@conf}" resp="#m42">
            <xsl:apply-templates/>
        </item>
    </xsl:template>

    <xsl:template match="tei:line_conf[parent::tei:p or parent::tei:head or parent::tei:ab[@type='catch-word' or @type='count-date' or @type='imprint' or @type='count-date' or @type='figure' or @type='main-title']]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:word_conf">
        <w cert="{@conf}" resp="#m42"><xsl:apply-templates/></w>
    </xsl:template>

    <xsl:template match="tei:ab[@type='catch-word']">
        <fw xml:id="fw{position()}" facs="{@facs}" rend="#f" type="catch" rendition="#f">
            <xsl:apply-templates/>
        </fw>
    </xsl:template>
    
</xsl:stylesheet>