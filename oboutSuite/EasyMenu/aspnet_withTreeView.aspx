<%@ Page Language="C#" %>
<%@ Register TagPrefix="oem" Namespace="OboutInc.EasyMenu_Pro" Assembly="obout_EasyMenu_Pro" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Import Namespace="System.Data.OleDb"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="C#" runat="server">
	void Page_Load(object sender, EventArgs e) 
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
            ClientID= "r1",
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
</script>

<html>
	<head runat="server">
	    <title>obout ASP.NET Easy Menu examples</title>
		<style type="text/css">
			body {
			    font-family: Verdana; 
			    font-size: 11px; 
			    margin: 0px; 
			    padding: 20px
			}
			.title {
			    font-size: X-Large; 
			    padding: 20px; 
			    border-bottom: 2px solid gray;
			}
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
		</style>
	</head>
	<body>
        <script type="text/javascript">
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
        </script>
	    <form id="Form1" runat="server">
            <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
	        <span class="tdText"><b>ASP.NET Easy Menu -  With TreeView</b></span>
		    <br /><br />
            Right click on any node of the tree and select action from the context menu.	
			<br /><br />

		    <table cellpadding="10" cellspacing="5" border="0" width="100%">
			    <tr>
				    <td width="200" valign="top">
					    <obout:Tree Width="150px" runat="server" RootNodeStyle-NodeCSS="myroot" RootNodeStyle-SubNodeContainerCSS="mycontainer" ID="ObTree" CssClass="default" />
				    </td>
			    </tr>
		    </table>

		    <oem:EasyMenu id="EasyMenu1" runat="server" StyleFolder="styles" Width="150">
			    <components>
				    <oem:MenuItem id="menuItem5" OnClientClick="try {alertText(targetEl);} catch (e) {}" InnerHtml="Show Node's HTML"></oem:MenuItem>
				    <oem:MenuItem id="menuItem6" OnClientClick="try {expandCollapse(targetEl);} catch (e) {}"
					    InnerHtml="Expand/Collapse Node"></oem:MenuItem>
			    </components>
		    </oem:EasyMenu>
		    
		    <br /><br /><br />
		    
            <a style="font-size:10pt;font-family:Tahoma" href="Default.aspx?type=ASPNET">« Back to examples</a>
		
		</form>
	</body>
</html>