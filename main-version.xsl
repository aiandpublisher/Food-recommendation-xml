<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns="http://www.w3.org/1999/xhtml"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0"
        exclude-result-prefixes="#all">
        
        <!-- For output we want to create an html file. -->
        <xsl:output method="html"/>
        
        
        <!-- The template match="/" is a bit long and is thus placed in the bottom of this document -->
        
        <!-- This template writes the main section of the page, which is information about restaurants -->
        <xsl:template match="/TEI/text/body/div1/div2">
            <div class="between_restaurant" style="background-color:#3D5A80;color:white;padding:4px;border:2px solid #3D5A80;border-radius:5px;">
                <ul> 
                    <li type="square">
                        <xsl:choose>
                            <xsl:when test="p/desc/rs/choice/corr='Vegans' or p/desc/rs/supplied=' Vegans'">
                                <h3 style="font-weight:bold;border:5px">
                                    <xsl:apply-templates select="head/name"/>
                                    <xsl:text>&#160;&#160;</xsl:text>
                                    <i><xsl:value-of select="p/desc/num"/></i>
                                    <span class="vegan" style="float:right">
                                        <xsl:text>Vegan-friendly&#160;</xsl:text></span>
                                </h3>
                            </xsl:when>
                            <xsl:when test="p/desc/rs='Chicken' or p/desc/rs/supplied='Chicken'">
                                <h3 style="font-weight:bold;border:5px">
                                    <xsl:apply-templates select="head/name"/>
                                    <xsl:text>&#160;&#160;</xsl:text>
                                    <i><xsl:value-of select="p/desc/num"/></i>
                                    <span class="chicken" style="float:right">
                                        <xsl:text>Chicken&#160;</xsl:text></span>
                                </h3>
                            </xsl:when>
                            <xsl:when test="p/desc/rs/supplied='Seafood&amp;Steak'">
                                <h3 style="font-weight:bold;border:5px">
                                    <xsl:apply-templates select="head/name"/>
                                    <xsl:text>&#160;&#160;</xsl:text>
                                    <i><xsl:value-of select="p/desc/num"/></i>
                                    <span class="seafood_steakhouse" style="float:right">
                                        <xsl:text>Seafood or Steakhouse&#160;</xsl:text></span>
                                </h3>
                            </xsl:when>
                            <xsl:when test="p/desc/rs/choice/corr='Brunch' or p/desc/rs/supplied=' Brunch'">
                                <h3 style="font-weight:bold;border:5px">
                                    <xsl:apply-templates select="head/name"/>
                                    <xsl:text>&#160;&#160;</xsl:text>
                                    <i><xsl:value-of select="p/desc/num"/></i>
                                    <span class="brunch" style="float:right">
                                        <xsl:text>Brunch&#160;</xsl:text></span>
                                </h3>
                            </xsl:when>
                            <xsl:otherwise>
                                
                                <h3 style="font-weight:bold;border:5px">
                                    <xsl:apply-templates select="head/name"/>
                                    <xsl:text>&#160;&#160;</xsl:text>
                                    <i><xsl:value-of select="p/desc/num"/></i>
                                </h3>
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                    <div class="description" style="background-color:#E1EDF4;color:#293241;border:2px solid #E1EDF4;border-radius:5px;">
                        <xsl:apply-templates select="p/desc"/>
                        <xsl:apply-templates select="div3"/>
                    </div>
                </ul>
            </div>
            <br/>
        </xsl:template>
        
        <!-- This template writes the names of the restaurants -->
        <xsl:template match="head/name">
            <xsl:choose>
                <xsl:when test="./choice">
                    <xsl:value-of select="choice/corr"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:template>
        
        <!-- This template writes the regional styles of the restaurants -->
        <xsl:template match="p/desc">
            <blockquote><li><span style="font-weight:bold"><xsl:text> Regional Style: &#160;&#160;</xsl:text>
                
                <xsl:choose>
                    <xsl:when test="rs[@type='style']/choice">
                        <xsl:value-of select="rs[@type='style']/choice/corr"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="rs[@type='style']"/>
                    </xsl:otherwise>
                </xsl:choose>
                </span>
            </li></blockquote>
        </xsl:template>
        
        <!-- This template writes the details of the restaurants -->
        <xsl:template match="div3">
            <blockquote><li><span style="font-weight:bold"><xsl:text> Must try:  </xsl:text></span>
                <xsl:choose>
                    <xsl:when test="p/desc/name[@role='specialty']">
                        <xsl:for-each select="p/desc/name[@role='specialty']">
                            <xsl:text> 「 </xsl:text>
                            <span style="color:#3D5A80">
                                <xsl:value-of select="."/>
                            </span>
                            <xsl:text> 」 </xsl:text> 
                        </xsl:for-each> 
                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>  Be brave and try!</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </li></blockquote>
            
            <blockquote><li><span style="font-weight:bold"><xsl:text> How is the food?  </xsl:text></span>
                <xsl:choose>
                    <xsl:when test="p/desc/gloss[@type='menu']">
                        
                        <xsl:for-each select="p/desc/gloss[@type='menu']">
                            <xsl:copy-of select="."/>
                            <xsl:text> ... </xsl:text>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="p/desc/gloss[@type='cuisine']"/>
                    </xsl:otherwise>
                </xsl:choose>
            </li></blockquote>
            
            <xsl:if test="p/desc/gloss[@type='environment'] or p/desc/gloss[@type='service']">
                <blockquote><li><span style="font-weight:bold"><xsl:text> Environment or service?  </xsl:text></span>
                <span>
                    <xsl:text> ... </xsl:text>
                    <xsl:if test="p/desc/gloss[@type='environment']">
                    <xsl:copy-of select="p/desc/gloss[@type='environment']"/>
                    <xsl:text> ...</xsl:text>
                    </xsl:if>
                    <xsl:if test="p/desc/gloss[@type='service']">
                    <xsl:copy-of select="p/desc/gloss[@type='service']"/>
                    <xsl:text> ...</xsl:text> 
                    </xsl:if>
                </span>
                </li></blockquote>
            </xsl:if>
            
            <xsl:if test="p/desc/gloss[@type='tips'] or p/note">
            <blockquote><li><span style="font-weight:bold"><xsl:text> More information?  </xsl:text></span>
                <xsl:if test="p/desc/gloss[@type='tips']">
                <span> 
                    <xsl:copy-of select="p/desc/gloss[@type='tips']"/>
                </span>
                <xsl:text>...</xsl:text>
                </xsl:if>
                <xsl:if test="p/note">
                    <xsl:text> TimeOut professional journalists says "</xsl:text>
                    <span style="font-style:italic"> 
                        <xsl:value-of select="p/note/q"/>
                    </span>
                    <xsl:text> "...</xsl:text>
                </xsl:if>
            </li></blockquote>
            </xsl:if>
        </xsl:template>
        
        
        <!-- This template deals with everything displayed on the html page -->
        <xsl:template match="/">
            <html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                <head>
                    <title>where to eat</title>
                    <style type="text/css"> /* internal css code for formatting */
                        a:link {
                        color:LightCyan;
                        }
                        a:visited {
                        color:LightCyan;
                        }
                        a:hover {
                        color:#98C1D9;
                        text-decoration:none;
                        }
                        a:active {
                        color:#EE6C4D;
                        text-decoration:none;
                        }
                        .all_stations{ /* the main recommendation section */
                        margin-top:25%;
                        }
                        body{  
                        font-family:Arial;
                        font-size:12pt;
                        padding:20px;
                        background-color:#F2F4F8;
                        height:100%;
                        overflow:scroll;
                        }
                        .wrap{  /* the right part of the page */
                        margin-left:30%;
                        overflow:scroll;
                        float:left;
                        width:70%;
                        }
                        #title{ /* the main title of the page */
                        padding:10px;
                        border-radius: 8px;
                        text-align:center;
                        color:white;
                        background-color:#3D5A80;
                        float:left;
                        width:100%;
                        height:25%;
                        font-size:80%;
                        overflow:hidden;
                        }
                        .occasion{ /* sub-titles for different categories of restaurants */
                        font-weight:bold;
                        color:#EE6C4D;
                        text-align:right;
                        font-size:150%;
                        line-height:10%;
                        }
                        .all_occasions{ /* the content of restaurant recommendation of each station */
                        height:400px;
                        overflow:scroll;
                        margin:2px;
                        }
                        .vegan{ /* sign of vegan-friendly restaurants */
                        color:LightCyan; 
                        text-align:right;
                        }
                        .chicken{ /* sign of chicken*/
                        color:#FCF6BD; 
                        text-align:right;
                        }
                        .seafood_steakhouse{ /* sign of seafood and steakhouse  */
                        color:#A9DEF9; 
                        text-align:right;
                        }
                        .brunch{ /* sign of brunch */
                        color:#F4CBC6;
                        text-align:right;
                        }
                        #intro{ /* the static left side bar */
                        margin-top:5px;
                        float:left;
                        width:auto;
                        height:95%;
                        font-size:70%;
                        color:#293241;
                        line-height:150%;
                        text-align:left;
                        }
                        .between_list{ /* lists in the left side bar */
                        color:#3D5A80;
                        font-size:90%;
                        }
                        #editor{ /* the upper part of the left side bar - editorial information */
                        padding:15px;
                        width:23%;
                        border-radius:8px;
                        text-align:center;
                        color:white;
                        font-size:105%;
                        background-color:#3D5A80;
                        float:left;
                        overflow:scroll;
                        height:24%;
                        position:fixed;
                        }
                        #content{ /* the lower part of the left side bar - information about restaurant categories */
                        margin-top:16%;
                        float:left;
                        overflow:scroll;
                        width:22%;
                        height:63%;
                        border:8px solid #98C1D9;
                        border-radius:5px;
                        position:fixed;
                        }
                        h2{
                        font-size:180%;
                        }
                    </style>
                </head>
                
                <body>
                    <!-- The left side -->
                    <div id="editor" style="padding:4px">
                        <p>Collected from <a href="https://www.timeout.com">Timeout</a></p>
                        <p>Edited by 20053281</p> 
                        <p>Last updated on 16/04/2021</p>
                        <p><xsl:value-of select="count(//head/name/@xml:id)"/> restaurants included</p>
                        <br/>
                        <p style="text-align:left;font-size:95%;padding:5px">10 posts were chosen from timeout, each containing a detailed list of recommended restaurants in a certain area.
                           Tripadvisor and Zomato are used as supplementary reference for some missing content in the orginal texts.
                           It uses XML markup to tag information about names, price, specialties, styles, locations, descriptions about tastes, restaurant environment, menus, services, etc..</p>
                        <p style="text-align:left;font-size:95%;padding:5px">XSL and CSS stylesheets are used to remove duplicated restaurants, display selected and formatted contents according to underground stations.</p>
                        
                    </div>
                    
                    <div class="intro" style="padding:2px;">
                        <div id="content">
                        <ul>
                        <li type="square"><h3>Underground Stations:</h3></li>
                            <div class="between_intro" style="padding:1px">
                                <div class="between_list" style="padding:1px">
                                    <li>Finsbury Park to King's Cross</li>
                                    <li>King's Cross to Holborn</li>
                                    <li>Holborn to Leicester square</li>
                                    <li>Leicester square to Piccadilly circus</li>
                                    <li>Piccadilly circus to South Kensington</li>
                                    <li>South Kensington to Hammersmith</li>
                                </div>
                            </div>
                            <div class="between_intro" style="padding:1px">
                                <li type="square"><h3>Dining Occasions:</h3></li>
                                <div class="between_list" style="padding:1px">
                                    <li>Casual dining</li>
                                    <li>Quick bites</li>
                                    <li>Bakeries&amp;Coffee shop</li>
                                    <li>Bars and pubs</li>
                                    <li>Fine dining</li>
                                    <li>Desserts</li>
                                </div>
                            </div>
                            <div class="between_intro" style="padding:2px">
                                <li type="square"><h3>Price Range: </h3>
                                    <span style="color:#3D5A80;">￡ - ￡￡￡￡</span></li>
                            </div>
                        </ul>
                        </div>
                    </div>
                    
                    <!--  the right side -->
                    <div class="wrap">
                        
                        
                        <div id="title" style="padding:4px">
                            <h1 style="font-weight:bold;font-size:300%">「 Where To Eat in London 」</h1>
                            <h1 style="color:#e0ffff"> Make a dining choice along Picaddily line </h1>
                        </div>
                        
                        
                        <!--  the main recommendation section, it writes the getailed restaurant information for each station according to different occasions,
                              if that cateogry doesn't exist in the selected location, then it won't be included in the page  -->
                        <div class="all_stations">
                            
                            <div class="between_station">  
                                <h2 style="font-weight:bold"><span style="background-color:#3D5A80"> <xsl:text> &#160;</xsl:text> </span> <span style="color:#3D5A80"><xsl:text> &#160;</xsl:text>Finsbury Park - King's Cross</span></h2>  
                                <div class="all_occasions">
                               
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))])!=0">
                                         <div class="between_occasion">
                                             <h3 class="occasion">Look for a casual dining? </h3>
                                             <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))]">
                                                  <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                             </xsl:apply-templates> 
                                         </div>
                                    </xsl:if>
                               
                              
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))])!=0">
                                          <div class="between_occasion">
                                              <h3 class="occasion">Go for a quick bite? </h3>
                                              <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))]">
                                                  <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                              </xsl:apply-templates>  
                                          </div>
                                    </xsl:if>
                              
                               
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))])!=0">                         
                                         <div class="between_occasion">
                                             <h3 class="occasion">Bakeries, Coffee or tea? </h3>
                                             <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))]">
                                                   <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                             </xsl:apply-templates>
                                         </div>
                                    </xsl:if>
                                
                               
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))])!=0">                         
                                         <div class="between_occasion">
                                             <h3 class="occasion">Grab a glass of beer after work? </h3>
                                             <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))]">
                                                 <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                             </xsl:apply-templates>
                                         </div>
                                    </xsl:if>
                                
                               
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))])!=0">                         
                                        <div class="between_occasion"> 
                                            <h3 class="occasion">Enjoy a fancy dinner? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))]">
                                                 <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                
                                
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">You deserve some sugar! </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Caledonian Road')or(./p/desc/addrName='Angel')or(./p/desc/addrName='Islington')or(./p/desc/addrName='Canonbury'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                </div>
                            </div>
                            <br/><br/>
                            
                            <div class="between_station">
                                <h2 style="font-weight:bold"><span style="background-color:#3D5A80"> <xsl:text> &#160;</xsl:text> </span> <span style="color:#3D5A80"><xsl:text> &#160;</xsl:text>King's Cross - Russell Square - Horborn</span></h2>  
                                <div class="all_occasions">
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))])!=0">
                                        <div class="between_occasion">
                                            <h3 class="occasion">Look for a casual dining? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates></div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))])!=0">
                                        <div class="between_occasion">
                                            <h3 class="occasion">Go for a quick bite? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Bakeries, Coffee or tea? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Grab a glass of beer after work? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))])!=0">                         
                                        <div class="between_occasion">  
                                            <h3 class="occasion">Enjoy a fancy dinner? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">You deserve some sugar! </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Gray’s Inn Road')or(./p/desc/addrName='King’s Cross')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn')or(./p/desc/addrName='Warren Street')or(./p/desc/addrName='Fitzrovia')or(./p/desc/addrName='Tottenham Court Road')or(./p/desc/addrName='Goodge Street'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                </div>
                            </div>
                            <br/><br/>
                            
                            <div class="between_station">
                                <h2 style="font-weight:bold"><span style="background-color:#3D5A80"> <xsl:text> &#160;</xsl:text> </span> <span style="color:#3D5A80"><xsl:text> &#160;</xsl:text>Horborn - Covent Garden - Leicester square</span></h2>  
                                <div class="all_occasions">
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))])!=0">
                                        <div class="between_occasion">
                                            <h3 class="occasion">Look for a casual dining? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))])!=0">
                                        <div class="between_occasion"> 
                                            <h3 class="occasion">Go for a quick bite? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Bakeries, Coffee or tea? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Grab a glass of beer after work? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Enjoy a fancy dinner? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">You deserve some sugar! </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                </div>
                            </div>
                            <br/><br/>
                            
                            <div class="between_station">
                                <h2 style="font-weight:bold"><span style="background-color:#3D5A80"> <xsl:text> &#160;</xsl:text> </span> <span style="color:#3D5A80"><xsl:text> &#160;</xsl:text>Leicester square - Piccadilly circus</span></h2>
                                <div class="all_occasions">
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))])!=0">
                                        <div class="between_occasion">
                                            <h3 class="occasion">Look for a casual dining? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))])!=0">
                                        <div class="between_occasion">
                                            <h3 class="occasion">Go for a quick bite? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Bakeries, Coffee or tea? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Grab a glass of beer after work? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Enjoy a fancy dinner? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Soho')or(./p/desc/addrName='Chinatown')or(./p/desc/addrName='Bloomsbury')or(./p/desc/addrName='Holborn'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">You deserve some sugar! </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Covent Garden')or(./p/desc/addrName='Seven Dials'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                </div>
                            </div>
                            <br/><br/>
                            
                            <div class="between_station">
                                <h2 style="font-weight:bold"><span style="background-color:#3D5A80"> <xsl:text> &#160;</xsl:text> </span> <span style="color:#3D5A80"><xsl:text> &#160;</xsl:text>Piccadilly circus - Green Park - South Kensington</span></h2>
                                <div class="all_occasions">
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))])!=0">
                                        <div class="between_occasion"> 
                                            <h3 class="occasion">Look for a casual dining? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))])!=0">
                                        <div class="between_occasion"> 
                                            <h3 class="occasion">Go for a quick bite? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>  
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Bakeries, Coffee or tea? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>  
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Grab a glass of beer after work? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Enjoy a fancy dinner? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>  
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))])!=0">                         
                                        <div class="between_occasion"> 
                                            <h3 class="occasion">You deserve some sugar! </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Mayfair') or (./p/desc/addrName='Park Lane')or(./p/desc/addrName='Piccadilly')or(./p/desc/addrName='Belgravia'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                </div>
                            </div>
                            <br/><br/>
                            
                            <div class="between_station">
                                <h2 style="font-weight:bold"><span style="background-color:#3D5A80"> <xsl:text> &#160;</xsl:text> </span> <span style="color:#3D5A80"><xsl:text> &#160;</xsl:text>South Kensington - Earl's Court - Hammersmith</span></h2>
                                <div class="all_occasions"> 
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))])!=0">
                                        <div class="between_occasion">
                                            <h3 class="occasion">Look for a casual dining? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Casual dining')or(./p/desc/rs/supplied=' Casual dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))])!=0">
                                        <div class="between_occasion">
                                            <h3 class="occasion">Go for a quick bite? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Quick bites')or(./p/desc/rs/supplied=' Quick bites'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Bakeries, Coffee or tea? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Coffee&amp;tea')or(./p/desc/rs/supplied=' Coffee&amp;tea')or(./p/desc/rs/choice/corr='Bakeries')or(./p/desc/rs/choice/corr='Bakeries'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Grab a glass of beer after work? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Bars')or(./p/desc/rs/supplied=' Bars'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates>  
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">Enjoy a fancy dinner? </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Fine dining')or(./p/desc/rs/supplied=' Fine dining'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="count(/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))])!=0">                         
                                        <div class="between_occasion">
                                            <h3 class="occasion">You deserve some sugar! </h3>
                                            <xsl:apply-templates select="/TEI/text/body/div1/div2[((./p/desc/addrName='Hammersmith') or (./p/desc/addrName='Fulham')or(./p/desc/addrName='South Kensington'))and((./p/desc/rs/choice/corr='Desserts')or(./p/desc/rs/supplied=' Desserts'))]">
                                                <xsl:sort select="p/desc/num/@value" order="ascending" data-type="number"/>
                                            </xsl:apply-templates> 
                                        </div>
                                    </xsl:if>
                                </div>
                            </div>
                            <br/>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:template>
</xsl:stylesheet>
