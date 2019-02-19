<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net"%>
<%@ Page Language="VB" Inherits="OboutInc.oboutAJAXPage"%>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data" %>
<script language="VB" runat="server">
    Private Sub Page_Load(sender As Object, e As EventArgs)

        Dim rootNode As New Node() With { _
         .Expanded = True, _
         .Text = "Personal Folders", _
         .ClientID = "a0", _
         .ImageUrl = "../treeview/icons/oMailbox.gif" _
        }
        ObTree.Nodes.Add(rootNode)

        rootNode.ChildNodes.Add(New Node() With { _
         .Text = "Deleted Items", _
         .ClientID = "a0_0", _
         .ImageUrl = "../treeview/icons/oRecycle.gif" _
        })
        rootNode.ChildNodes.Add(New Node() With { _
         .Text = "Drafts", _
         .ClientID = "a0_1", _
         .ImageUrl = "../treeview/icons/oDrafts.gif" _
        })
        rootNode.ChildNodes.Add(New Node() With { _
         .Text = "Inbox", _
         .ClientID = "a0_2", _
         .ImageUrl = "../treeview/icons/oInbox.gif", _
         .Selected = True _
        })
        rootNode.ChildNodes.Add(New Node() With { _
         .Text = "Junk E-mail", _
         .ClientID = "a0_3", _
         .ImageUrl = "../treeview/icons/oJunk.gif" _
        })
        rootNode.ChildNodes.Add(New Node() With { _
         .Text = "Outbox", _
         .ClientID = "a0_4", _
         .ImageUrl = "../treeview/icons/oOutlook.gif" _
        })
        rootNode.ChildNodes.Add(New Node() With { _
         .Text = "Sent Items", _
         .ClientID = "a0_5", _
         .ImageUrl = "../treeview/icons/oSent.gif" _
        })

        Dim searchNode = New Node() With { _
         .Expanded = True, _
         .Text = "Search Folders", _
         .ClientID = "a0_6", _
         .ImageUrl = "../treeview/icons/oSearch.gif" _
        }
        rootNode.ChildNodes.Add(searchNode)

        searchNode.ChildNodes.Add(New Node() With { _
         .Text = "For Follow Up", _
         .ClientID = "a0_6_0", _
         .ImageUrl = "../treeview/icons/oSearch.gif" _
        })
        searchNode.ChildNodes.Add(New Node() With { _
         .Text = "Unread Mail", _
         .ClientID = "a0_6_1", _
         .ImageUrl = "../treeview/icons/oSearch.gif" _
        })

        Dim myMailNode = New Node() With { _
         .Expanded = True, _
         .Text = "mymail.com", _
         .ClientID = "a1", _
         .ImageUrl = "../treeview/icons/oInboxF.gif" _
        }
        rootNode.ChildNodes.Add(myMailNode)

        myMailNode.ChildNodes.Add(New Node() With { _
         .Text = "Inbox", _
         .ClientID = "a1_0", _
         .ImageUrl = "../treeview/icons/oInbox.gif" _
        })
        myMailNode.ChildNodes.Add(New Node() With { _
         .Text = "Junk E-mail", _
         .ClientID = "a1_1", _
         .ImageUrl = "../treeview/icons/oJunk.gif" _
        })
        myMailNode.ChildNodes.Add(New Node() With { _
         .Text = "Sent", _
         .ClientID = "a1_2", _
         .ImageUrl = "../treeview/icons/oSent.gif" _
        })
        myMailNode.ChildNodes.Add(New Node() With { _
         .Text = "Trash", _
         .ClientID = "a1_3", _
         .ImageUrl = "../treeview/icons/oSent.gif" _
        })
        myMailNode.ChildNodes.Add(New Node() With { _
         .Text = "Trash", _
         .ClientID = "a1_4", _
         .NavigateUrl = "http://www.memobook.com", _
         .Target = "_blank" _
        })


        ShowErrorsAtClient = False
    End Sub
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> <html>
	<head runat="server">
        <title></title>
        <style type="text/css">
		.Text
		{
			background-color:white;
			font-size:12px;
		}
		.inputButton
		{
			border:1px solid #6B89AF;
			width:250px;
		}
		body
		{
			font-family:Tahoma;
			font-size:8pt;
		}
		.pointer
		{
			cursor:pointer;
		}
		</style>
	</head>
	<body>
    <form runat="server">
    <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
    <script type="text/javascript">
        function clientNodeSelect(sender, args) {
            var id = args.node.id;
            if (id == null || id == "")
                return;
            EmailclientLoad(id);
        }
        function pageLoad(sender, args) {
            var tree = $find("<%=ObTree.ClientID %>");
            var node = tree.getSelectedNodes()[0];
            EmailclientLoad(node.id);
        }
        // load, specified by param, an email category
        function EmailclientLoad(CategoryID) {
            CategoryID = CategoryID.replace("a0_", "");
            CategoryID = CategoryID.replace("a1_", "");

            if (isNaN(CategoryID))
                CategoryID = 0;

            sp2.loadPage("TopContent", "aspnet_integration_email_client_list.aspx?CategoryID=" + CategoryID);
        }
    </script>
    <br />
    <span class="tdText"><b>ASP.NET Grid - As E-Mail Client</b></span>
    <br />
    <br />
    <a href="Default.aspx?type=VBNET">« Back to examples</a>
    <br />
    <br />
		<div style="height:53px; background-image:url('images/header.gif');border-right:1px solid gray;border-left:1px solid gray;">
			<img src="resources/images/header_buttons.gif" />
		</div>
		<obspl:Splitter CookieDays="0" id="sp1" runat="server" StyleFolder="../Splitter/styles/default">
			<LeftPanel WidthMin="100" WidthMax="400" WidthDefault="180">
				<Content>
					<div style="padding-left:10px;padding-top:10px;padding-right:10px;"> 
                        <obout:Tree ID="ObTree" runat="server" OnNodeSelect="clientNodeSelect">
                        </obout:Tree>
					</div>
				</Content>
			</LeftPanel>
			<RightPanel>
				<Content>
					<obspl:HorizontalSplitter CookieDays="0" id="sp2" runat="server" StyleFolder="../Splitter/styles/default">
						<TopPanel HeightMin="100" HeightMax="600" HeightDefault="250">
							<Content></Content>
						</TopPanel>
						<BottomPanel>
							<Content></Content>
						</BottomPanel>
					</obspl:HorizontalSplitter>
				</Content>
				<Footer Height="0"></Footer>
			</RightPanel>
		</obspl:Splitter>
        </form>
	</body>
</html>
