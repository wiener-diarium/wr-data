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
            <profileDesc>
                <langUsage>
                    <language ident="de">Deutsch</language>
                </langUsage>
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
            <funder>Austrian Academy of Sciences, go!digital 2.0</funder>
        </xsl:copy>
        <editionStmt>
            <edition>Wienerisches Diarium: Digitale Edition</edition>
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
    
    <xsl:template match="tei:text">
        <xsl:variable name="titlePage" select="./tei:body/tei:div[1]"/>
        <xsl:copy>
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
                        <titlePart>
                            <xsl:call-template name="imprint"/>
                        </titlePart>
                    </docTitle>
                </titlePage>
            </front>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:div[1][parent::tei:body]"/>
     
    <xsl:template match="tei:div[position() > 1][parent::tei:body]">
        <xsl:copy>
            <xsl:attribute name="type" select="'article'"/>
            <xsl:attribute name="n" select="(position() div 2) - 1"/>
            <xsl:attribute name="xml:id" select="concat('a', (position() div 2) - 1)"/>
            <xsl:apply-templates select="node()|@*"/> 
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:principal"/>
    
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
         <xsl:if test="./following-sibling::node()[1]/self::text()[normalize-space()]">
             <xsl:copy>
                 <xsl:apply-templates select="node()|@*"/>
             </xsl:copy>
         </xsl:if>
    </xsl:template> 
    
    <xsl:template name="imprint">
        <xsl:for-each select="//tei:ab[@type='imprint' and contains(@facs, 'facs_1_')]">
            <xsl:apply-templates select="node()|@*"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="num">
        <xsl:param name="context"/>
        <xsl:for-each select="$context/tei:ab[@type='count-date-normalized']">
            <xsl:attribute name="facs">
                <xsl:value-of select="$context/tei:ab[@type='count-date'][1]/@facs"/>
            </xsl:attribute>
            <xsl:apply-templates select="node()|@*"/>
            <!-- <xsl:attribute name="facs" select="@facs"/>
            <xsl:attribute name="type" select="@type"/>
            <xsl:variable name="num" select="if(contains(.[1]/text()[last()], 'Num')) then(.[1]/text()[last()]) else(.[1]/text()[1])"/>
            <xsl:variable name="date" select="if(count(.[1]/text()) = 5) then(concat(.[1]/text()[4], .[1]/text()[3])) else(.[1]/text()[3])"/>
            <xsl:variable name="year" select="if(contains(.[1]/text()[2], '17')) then(.[1]/text()[2]) else(.[1]/text()[last()])"/>
            <xsl:value-of select="concat(replace($num, '\n\s+', ''), ' ', replace($date, '\n\s+', ' '), ' ', replace($year, '\n\s+', ''))"/> -->
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="main-title">
        <xsl:for-each select="//tei:ab[@type='main-title' and contains(@facs, 'facs_1_')]">
            <xsl:variable name="text" select="string-join(./text(), ' ')"/>
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
    
</xsl:stylesheet>