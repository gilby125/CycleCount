<%@ Page Language="c#" Inherits="cs_addressbook" CodeFile="cs_addressbook.aspx.cs"%>
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net"%>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>obout ASP.NET Splitter examples</title>
		<style type="text/css">
		    .tdText {
	            font:11px Verdana;
	            color:#333333;
             }
		    .title 
		    {
			    font-size: X-Large; 
			    padding: 20px; 
			    border-bottom: 2px solid gray; 
			    width: 100%; 
		    }
		    body
		    {
			    font-family:Verdana;
		    }
		    .text
		    {
			    background-color:#ebe9ed;
			    font-size:11px;
			    text-align:center;
		    }
		    .pointer
		    {
			    cursor:pointer;
		    }
            .myroot .ic
            {
	            display: none !important;
	            height: 0px !important;
	            width: 0px !important;
            }
            .myroot
            {
	            background: none !important;
	            padding-left: 0px !important;
            }
            .mycontainer
            {
	            padding-left: 0px !important;
	            margin-left: -2px !important;
            }
		</style>
	</head>
	<body>
	    <form id="Form1" runat="server">
            <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
	        <br />
		    <span class="tdText"><b>ASP.NET Splitter - Address Book</b></span>
    	
		    <br /><br />
		    <a style="font-size:10pt;font-family:Tahoma" href="Default.aspx?type=CSHARP">« Back to examples</a>
		    <br /><br />	  
	        <obspl:Splitter CookieDays="0" id="sp1DVF" runat="server" StyleFolder="styles/default">
		        <LeftPanel WidthMin="100" WidthMax="400" WidthDefault="210" >
			        <Header Height="40">
				        <div style="width:100%;height:100%;" class="text">
					        <br />
				        </div>
			        </Header>
			        <Content>
				        <div style="width:190px;padding-left:10px;padding-top:10px">
                            <asp:UpdatePanel runat="server"><ContentTemplate>
    					        <obout:Tree Width="200px" runat="server" RootNodeStyle-NodeCSS="myroot" RootNodeStyle-SubNodeContainerCSS="mycontainer" OnSelectedTreeNodeChanged="NodeSelected" AutoPostBackOnNodeSelect="true" ID="ObTree" CssClass="default" />
                            </ContentTemplate></asp:UpdatePanel>
				        </div>
			        </Content>
			        <Footer Height="40">
				        <div style="width:100%;height:100%;" class="text">
					        <br />
					        optional footer
				        </div>
			        </Footer>
		        </LeftPanel>
		        <RightPanel>
			        <Content>
				        <table border="0">
					        <tr>
						        <td colspan="2">&nbsp;</td>
					        </tr>
					        <tr>
						        <td colspan="2">
							        <div style="padding-left:20px;font-weight:bold;font-size:12px">
								        <h3>Address book example</h3>
								        Please select a person from the address book to retrieve the contact <br />
								        information from the database.
								        <br /><br />
							        </div>
						        </td>
					        </tr>
					        <tr>
						        <td colspan="2" style="padding-left:20px" valign="top">
                                    <asp:UpdatePanel runat="server" ID="PersonalInfo" UpdateMode="Conditional"><ContentTemplate>
                                        <asp:Panel runat="server" Visible="false" ID="PersonalInfoPanel">
									        <table width="100%" style="height:100%" cellpadding="0" cellspacing="0">
										        <tr>
											        <td style="width:150px" class="h5" valign="top">
												        <asp:Literal id="lContactImage" runat="server" />
											        </td>
											        <td valign="top" class="h5" style="padding-left:5px;width:100%;">	
												        <asp:Literal id="lContactName" runat="server" /><br />
												        Company Name: <asp:Literal id="lContactCompany" runat="server" /><br />
												        E-mail: <asp:Literal id="lContactEmail" runat="server" /><br />
												        Phone Number: <asp:Literal id="lContactPhone" runat="server" /><br />
												        Cell Phone Number: <asp:Literal id="lContactCell" runat="server" /><br />
												        Fax Number: <asp:Literal id="lContactFax" runat="server" /><br />
											        </td>				
										        </tr>
									        </table>
                                        </asp:Panel>
                                    </ContentTemplate></asp:UpdatePanel>
						        </td>
					        </tr>
				        </table>
			        </Content>
		        </RightPanel>
	        </obspl:Splitter>
	     </form>
	</body>
</html>
