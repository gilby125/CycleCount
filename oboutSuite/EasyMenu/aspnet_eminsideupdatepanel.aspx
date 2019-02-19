<%@ Page Language="C#" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="C#" runat="server">
	void Page_Load(object sender, EventArgs e) 
	{
        if (!Page.IsPostBack)
        {
            string attachTo = "root,";

            Node rootNode;
            Node firstNode;
            Node newNode;

            rootNode = new Node()
            {
                Text = "Hello, I am Root node!",
                Expanded = true,
                ClientID = "root",
                ImageUrl = "~/TreeView/icons/book.gif"
            };
            ObTree.Nodes.Add(rootNode);

            firstNode = new Node()
            {
                Text = "obout.com <span style='color:crimson;'>Home</span>",
                Expanded = true,
                ClientID = "r1",
                ImageUrl = "~/TreeView/icons/xpPanel.gif"
            };
            rootNode.ChildNodes.Add(firstNode);
            attachTo += "r1,";

            newNode = new Node()
            {
                Text = "ASPTreeView",
                Expanded = true,
                ClientID = "a0",
                ImageUrl = "~/TreeView/icons/folder.gif"
            };
            firstNode.ChildNodes.Add(newNode);
            attachTo += "a0,";

            newNode.ChildNodes.Add(new Node()
            {
                Text = "Small",
                ClientID = "a0_0",
                ImageUrl = "~/TreeView/icons/ball_glass_redS.gif"
            });
            attachTo += "a0_0,";

            newNode.ChildNodes.Add(new Node()
            {
                Text = "Fast",
                ClientID = "a0_1",
                ImageUrl = "~/TreeView/icons/ball_glass_redS.gif"
            });
            attachTo += "a0_1,";

            newNode.ChildNodes.Add(new Node()
            {
                Text = "Easy",
                ClientID = "a0_2",
                ImageUrl = "~/TreeView/icons/ball_glass_redS.gif"
            });
            attachTo += "a0_2,";

            newNode = new Node()
            {
                Text = "More nodes",
                Expanded = true,
                ClientID = "a1",
                ImageUrl = "~/TreeView/icons/folder.gif"
            };
            firstNode.ChildNodes.Add(newNode);
            attachTo += "a1,";

            newNode.ChildNodes.Add(new Node()
            {
                Text = "Different color",
                ClientID = "a1_0",
                ImageUrl = "~/TreeView/icons/ball_glass_blueS.gif"
            });
            attachTo += "a1_0,";

            newNode.ChildNodes.Add(new Node()
            {
                Text = "Any HTML",
                ClientID = "a1_1",
                ImageUrl = "~/TreeView/icons/ball_glass_blueS.gif"
            });
            attachTo += "a1_1,";

            newNode.ChildNodes.Add(new Node()
            {
                Text = "Select Icons",
                ClientID = "a1_2",
                ImageUrl = "~/TreeView/icons/ball_glass_blueS.gif"
            });
            attachTo += "a1_2,";

            newNode.ChildNodes.Add(new Node()
            {
                Text = "Memobook",
                ClientID = "a1_3",
                ImageUrl = "~/TreeView/icons/ball_glass_blueS.gif"
            });
            attachTo += "a1_3,";

            newNode = new Node()
            {
                Text = "Recycle :)",
                Expanded = true,
                ClientID = "a2",
                ImageUrl = "~/TreeView/icons/recycle.gif"
            };
            firstNode.ChildNodes.Add(newNode);
            attachTo += "a2";

            EasyMenu1.AttachTo = attachTo;
        }
        updatePanel1.PreRender += new EventHandler(BeforePanelUpdate);
    }
	
	private void BeforePanelUpdate(object sender, EventArgs args)
	{
        if (Page.IsPostBack)
        {
            System.Threading.Thread.Sleep(2000);
        }
	}
	
</script>

<html>
	<head runat="server">
	    <title>obout ASP.NET Easy Menu examples</title>
		<style type="text/css">
            .tdText {
				        font:11px Verdana;
				        color:#333333;
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
            .progress
            {
                background-color:white;
                cursor:text !important;
                -moz-opacity:0.5;
                filter:alpha(opacity:50);
                opacity: 0.5;
            }
	    </style>
	</head>
	<script type="text/javascript">
		function UpdatePanel() {
		    ob_post.UpdatePanel("callbackPanel1");
		}
		function alertText(node) {
		    var tree = $find("<%= ObTree.ClientID %>");
		    alert(tree._getNodeTextContainer(node).innerHTML);
		}
		function expandCollapse(node) {
		    var tree = $find("<%= ObTree.ClientID %>");
		    if (tree.isExpanded(node)) {
		        tree.collapse(node);
		    } else {
		        tree.expand(node);
		    }
		}
		function pageLoad(sender, e) {
		    function invokingRequest() {
		        Sys.Net.WebRequestManager.remove_invokingRequest(invokingRequest);
		        $get("wait").style.visibility = "visible";
		        $get("updatePanel1").className = "progress";
		    }
		    Sys.Net.WebRequestManager.add_invokingRequest(invokingRequest);
		    var wait = $get("wait");
		    wait.style.visibility = "hidden";
		    $get("updatePanel1").className = "";
		}
	</script>
	 <body>
	    <form id="Form1" runat="server">
            <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
		    <span class="tdText"><b>ASP.NET Easy Menu - Easy Menu and TreeView inside Obout Callback Panel</b></span>
    	
		    <br /><br />
            Right click on any node of the tree and select action from the context menu.	
                <asp:UpdatePanel runat="server" ID="updatePanel1"><ContentTemplate>
				    <table cellpadding="0" cellspacing="0" border="0" width="100%">
					    <tr>
						    <td width="200" valign="top">
                                <img alt="" id="wait" style="visibility:hidden;position:relative;top:150px;left:60px;" src="<%=Page.ClientScript.GetWebResourceUrl(typeof(Obout.Ajax.UI.HTMLEditor.Editor), "Obout.Ajax.UI.HTMLEditor.Images.ed_wait.gif")%>" />
					            <obout:Tree Width="150px" runat="server" RootNodeStyle-NodeCSS="myroot" RootNodeStyle-SubNodeContainerCSS="mycontainer" ID="ObTree" CssClass="default" />
							    <oem:EasyMenu id="EasyMenu1" runat="server" StyleFolder="styles/horizontal4" Width="150">
								    <components>
				                        <oem:MenuItem id="menuItem5" OnClientClick="try {alertText(targetEl);} catch (e) {}" InnerHtml="Show Node's HTML"></oem:MenuItem>
				                        <oem:MenuItem id="menuItem6" OnClientClick="try {expandCollapse(targetEl);} catch (e) {}"
					                        InnerHtml="Expand/Collapse Node"></oem:MenuItem>
								    </components>
							    </oem:EasyMenu>
						    </td>
					    </tr>
				    </table>
		            <br />
		            <br />
		            <asp:Button runat="server" Text="Update Panel" />
                </ContentTemplate></asp:UpdatePanel>

                <br /><br /><br />
    		
		        <a style="font-size:10pt;font-family:Tahoma" href="Default.aspx?type=ASPNET">« Back to examples</a>
	    
        </form>
    </body>
</html>
