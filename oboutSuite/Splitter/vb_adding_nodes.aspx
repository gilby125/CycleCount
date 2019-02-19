<%@ Register Tagprefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Page Language="vb" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="vb" runat="server">
    Private Sub Page_Load(sender As Object, e As EventArgs)
        'build TreeView
        If Not Page.IsPostBack Then
            Dim rootNode As Node
            Dim newNode As Node

            rootNode = New Node() With { _
             .Text = "<span style='cursor:pointer'>I am Root node!</span>", _
             .Expanded = True, _
             .Selected = True, _
             .ImageUrl = "~/TreeView/icons/xpPanel.gif" _
            }
            ObTree.Nodes.Add(rootNode)

            newNode = New Node() With { _
             .Text = "<span style='cursor:pointer;'>Obout Inc</span>", _
             .Expanded = True, _
             .Selected = True, _
             .ImageUrl = "~/TreeView/img/folder.png" _
            }
            rootNode.ChildNodes.Add(newNode)

            newNode = New Node() With { _
             .Text = "<span style='cursor:pointer;'>Brooklyn Bridge</span>", _
             .Expanded = True, _
             .ImageUrl = "~/TreeView/img/folder.png" _
            }
            rootNode.ChildNodes.Add(newNode)

            newNode.ChildNodes.Add(New Node() With { _
             .Text = "<span style='cursor:pointer;'>Drawing</span>", _
             .ImageUrl = "~/TreeView/img/folder.png" _
            })

            newNode.ChildNodes.Add(New Node() With { _
             .Text = "<span style='cursor:pointer;'>Picture</span>", _
             .ImageUrl = "~/TreeView/img/folder.png" _
            })

            newNode = New Node() With { _
             .Text = "<span style='cursor:pointer;'>Picture</span>", _
             .Expanded = True, _
             .ImageUrl = "~/TreeView/img/folder.png" _
            }
            rootNode.ChildNodes.Add(newNode)

            newNode.ChildNodes.Add(New Node() With { _
             .Text = "<span style='cursor:pointer;'>Obout Inc</span>", _
             .ImageUrl = "~/TreeView/img/folder.png" _
            })

            newNode.ChildNodes.Add(New Node() With { _
             .Text = "<span style='cursor:pointer;'>My Pictures</span>", _
             .ImageUrl = "~/TreeView/img/folder.png" _
            })
        ElseIf NewNodeName.Value.Length > 0 Then
            ' add a new node
            ObTree.SelectedNode.ChildNodes.Add(New Node() With { _
             .Text = NewNodeName.Value, _
             .ImageUrl = "~/TreeView/icons/ball_blueS.gif" _
            })
            Dim parent As Node = ObTree.SelectedNode.Parent
            While parent IsNot Nothing
                parent.Expanded = True
                parent = parent.Parent
            End While
            NewNodeName.Value = ""
        End If
    End Sub
    Private Sub NodeSelected(sender As Object, e As NodeEventArgs)
    End Sub
</script>

<script type="text/javascript">
    function AddNode() {
        var nodeName = document.getElementById('txtNodeName').value;
        $get("<%= NewNodeName.ClientID %>").value = nodeName;
        window.parent.__doPostBack("<%= ObTree.UniqueID %>", JSON.stringify({ type: "ServerSide", NodeIndex: selectedNodeIndex }));
    }
    var selectedNodeIndex = "0";
    function clientOnNodeSelect(sender, args) {
        var obTree = $find("<%=ObTree.ClientID%>");
        selectedNodeIndex = obTree.getNodeIndex(args.node);
    }
</script>

<html>
	<head id="Head1" runat="server">
	    <title>obout ASP.NET Splitter examples</title>
    	   
        <style type="text/css">
            .tdText 
		    {
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
	    <form id="Form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
	    <br />
		<span class="tdText"><b>ASP.NET Splitter - Control left panel from right panel</b></span>
	    <br /><br />
	         <a style="font-size:10pt;font-family:Tahoma" href="Default.aspx?type=VB">« Back to examples</a>
	        <br /><br />
		    <div style="width:686px;height:440px;border:1px solid #ebe9ed">
			    <obspl:Splitter StyleFolder="styles/default" id="splDV" runat="server" CookieDays="0">
				    <LeftPanel WidthMin="100" WidthMax="400">
					    <header height="40">
						    <div style="width:100%;height:100%;background-color:#e0e6ed" class="tdText" align="center">
						    <br />
						    optional left header
						    </div>
					    </header>
					    <content>
						    <div style="margin:5px;"> 
                                <asp:UpdatePanel runat="server"><ContentTemplate>
                                    <obout:Tree runat="server" RootNodeStyle-NodeCSS="myroot" RootNodeStyle-SubNodeContainerCSS="mycontainer" OnNodeSelect="clientOnNodeSelect" OnSelectedTreeNodeChanged="NodeSelected" AutoPostBackOnNodeSelect="true" ID="ObTree" CssClass="default" />
                                    <asp:HiddenField runat="server" ID="NewNodeName" Value="" />
                                </ContentTemplate></asp:UpdatePanel>
						    </div>
					    </content>
					    <footer height="40">
						    <div style="width:100%; height: 100%;background-color:#e0e6ed;" class="tdText" align="center">
						    <br />
						    optional left footer
						    </div>
					    </footer>
				    </LeftPanel>
				    <RightPanel>
				    <header height="50">
						    <div style="width:100%;height:100%;background-color:#ebe9ed" class="tdText" align="center">
						    <br />
						    optional right header
						    </div>
					    </header>
					    <content>
					    <div style="font:11px verdana; color: #333333; padding-left:20px; padding-top:20px;">
						    Add node to the treeview in left panel using button in right panel.
						    <br />
						    <br />
						    Node text: <input type='text' id='txtNodeName' value='New Node'  style="font:11px verdana;" />
						    &nbsp;<input type='button' value='Add' onclick='AddNode()' style="font:11px verdana;" />
						    <br /><br /><br />
					    </div>
					    </content>
					    <footer height="50">
						    <div style="width:100%;height:100%;background-color:#ebe9ed" class="tdText" align="center">
						    <br />
						    optional right footer
						    </div>
					    </footer>
				    </RightPanel>
			    </obspl:Splitter>
		    </div>
		 </form>
	</body>
</html>