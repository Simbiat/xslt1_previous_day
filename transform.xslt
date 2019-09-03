<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="date">
        <!--Get previous day number-->
        <xsl:variable name="pdd_init">
            <xsl:choose>
                <!--If original date was 1 (or less) and we get 0 (or less) or if date is more than 31 - enforce 31. This is temporary and will be updated later-->
                <xsl:when test="dd - 1 &lt;= 0 or dd &gt; 31">
                    <xsl:text>31</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="dd - 1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--Get previous month number-->
        <xsl:variable name="pmm_init">
            <xsl:choose>
                <!--Change month only if previous day number implies it-->
                <xsl:when test="$pdd_init = 31">
                    <xsl:choose>
                        <!--If original month was 1 (January) and we get 0 or if month was more than 12 - enforce 12 (December)-->
                        <xsl:when test="mm - 1 &lt;= 0 or mm &gt; 12">
                            <xsl:text>12</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="mm - 1" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <!--Retain current month-->
                <xsl:otherwise>
                    <xsl:value-of select="mm" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--Correct previous day number if its end of month-->
        <xsl:variable name="pdd_init2">
            <xsl:choose>
                <!--Logic in case of 31 or greater (just in case)-->
                <xsl:when test="$pdd_init &gt;= 31">
                    <xsl:choose>
                        <!--Retain 31 for January, March, May, July, August, October and December-->
                        <xsl:when test="$pmm_init=1 or $pmm_init=3 or $pmm_init=5 or $pmm_init=7 or $pmm_init=8 or $pmm_init=10 or $pmm_init=12">
                            <xsl:text>31</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <!--Else check if February-->
                                <xsl:when test="$pmm_init=2">
                                    <!--Check for leap year and update to 29 or 28 respectively-->
                                    <xsl:choose>
                                        <xsl:when test="not(yyyy mod 4) and (yyyy mod 100 or not(yyyy mod 400))">
                                            <xsl:text>29</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>28</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <!--Update to 30 if not-->
                                <xsl:otherwise>
                                    <xsl:text>30</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <!--If not 31 we may be in February, which needs an update-->
                <xsl:otherwise>
                    <xsl:choose>
                        <!--If February and is 29 or more we check for leap year and update accordingly-->
                        <xsl:when test="$pmm_init=2 and $pdd_init &gt;= 29">
                            <xsl:choose>
                                <xsl:when test="not(yyyy mod 4) and (yyyy mod 100 or not(yyyy mod 400))">
                                    <xsl:text>29</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>28</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <!--Else retain original value-->
                        <xsl:otherwise>
                            <xsl:value-of select="$pdd_init" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--Preventing month being more than 12 (just in case)-->
        <xsl:variable name="pmm_init2">
            <xsl:choose>
                <xsl:when test="$pmm_init &gt; 12">
                    <xsl:text>12</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$pmm_init" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--If previous day is December 31, this implies year change-->
        <xsl:variable name="pyy_init">
            <xsl:choose>
                <xsl:when test="$pdd_init2=31 and $pmm_init=12">
                    <xsl:value-of select="yyyy - 1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="yyyy" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--If year is less than zero - enforce 1-->
        <xsl:variable name="pyy_init2">
            <xsl:choose>
                <xsl:when test="$pyy_init &lt;= 0">
                    <xsl:text>1</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$pyy_init" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--Add leading zeros-->
        <xsl:variable name="pyyyy" select="substring(concat('0000', $pyy_init2), string-length($pyy_init2) + 1)"/>
        <xsl:variable name="pmm" select="substring(concat('00', $pmm_init2), string-length($pmm_init2) + 1)"/>
        <xsl:variable name="pdd" select="substring(concat('00', $pdd_init2), string-length($pdd_init2) + 1)"/>
        <!--Output-->
        <xsl:value-of select="$pyyyy" />
        <xsl:value-of select="$pmm" />
        <xsl:value-of select="$pdd" />
    </xsl:template>
</xsl:stylesheet>
