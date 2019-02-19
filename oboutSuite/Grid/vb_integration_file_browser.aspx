<%@ Page Language="VB" ASPCOMPAT="TRUE" Inherits="OboutInc.oboutAJAXPage"%>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>

<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Register TagPrefix="ogrid" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %> 
<%@ Register TagPrefix="spl2" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<script language="VB" runat="server">
Private initialDirectory As String = "resources/FileBrowser"
    Private DefaultFolder As String
    Private expandedLevel As Integer = 0

    Private Sub Page_Load(sender As Object, e As EventArgs)

        DefaultFolder = Server.MapPath(initialDirectory)

        ThrowExceptionsAtClient = True
        ShowErrorsAtClient = True

        LoadTreeView()

        ' set default initial directory
        If Not IsPostBack Then
            SelectDir(String.Empty)
        End If
    End Sub

    Private Sub LoadTreeView()
        Dim rootNode As New Node() With { _
         .Text = "File Browser", _
         .Expanded = True _
        }
        ObTree.Nodes.Add(rootNode)

        Dim rootFolder As New DirectoryInfo(DefaultFolder)
        LoadDirRecursive(rootNode, rootFolder)
    End Sub

    Private Sub LoadDirRecursive(ParentNode As Node, rootFolder As DirectoryInfo)
        expandedLevel += 1

        For Each dir As DirectoryInfo In rootFolder.GetDirectories()
            Dim dirName As String = dir.Name
            Dim dirID As String = dirName

            Dim expanded As Boolean = True
            If expandedLevel >= 15 Then
                expanded = False
            End If

            Dim child As New Node() With { _
             .ClientID = dirID, _
             .Text = dirName, _
             .Expanded = expanded, _
             .ImageUrl = "../TreeView/icons/folder.gif" _
            }
            ParentNode.ChildNodes.Add(child)

            LoadDirRecursive(child, New DirectoryInfo(Convert.ToString(rootFolder) & "/" & dirName))
        Next
    End Sub

    ' populate grid with directory content
    Public Sub SelectDir(dirID As String)
        dirID = initialDirectory & "\" & dirID

        ViewState("dirID") = dirID

        LoadGrid()

        UpdatePanel("cpDir")
    End Sub

    Public Sub LoadGrid()
        Dim dirID As String = ViewState("dirID").ToString()

        Dim dsDir As New DataSet()
        dsDir.Tables.Add(New DataTable())
        dsDir.Tables(0).Columns.Add(New DataColumn("name", System.Type.[GetType]("System.String")))
        dsDir.Tables(0).Columns.Add(New DataColumn("size", System.Type.[GetType]("System.Int32")))
        dsDir.Tables(0).Columns.Add(New DataColumn("type", System.Type.[GetType]("System.String")))
        dsDir.Tables(0).Columns.Add(New DataColumn("datemodified", System.Type.[GetType]("System.String")))
        dsDir.Tables(0).Columns.Add(New DataColumn("imageType", System.Type.[GetType]("System.String")))

        If dirID = "root_tree_0" Then
            dirID = initialDirectory
        End If

        Dim rootFolder As New DirectoryInfo(Server.MapPath(dirID.Replace("_", "/")))

        For Each dir As DirectoryInfo In rootFolder.GetDirectories()
            Dim dirName As String = dir.Name
            Dim dirDateTime As String = dir.LastAccessTime.ToString("d/M/yyyy h:m:s tt")
            Dim dirImageType As String = "Folder"
            dsDir.Tables(0).Rows.Add(New Object() {dirName, 0, "File Folder", dirDateTime, dirImageType})
        Next

        For Each file As FileInfo In rootFolder.GetFiles()
            Dim fileName As String = file.Name
            Dim fileSize As String = file.Length.ToString()
            Dim fileType As String = file.Extension.Replace(".", "")
            Dim fileImageType As String = "File"
            Dim fileDateTime As String = file.LastAccessTime.ToString("d/M/yyyy h:m:s tt")

            dsDir.Tables(0).Rows.Add(New Object() {fileName, fileSize, fileType, fileDateTime, fileImageType})
        Next

        gridDir.DataSource = dsDir
        gridDir.DataBind()
    End Sub
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> <html>
	<head runat="server">
        <title></title>
		<script type="text/javascript">
		    function SelectDir(dirID) {
		        ob_post.AddParam("dirID", dirID);
		        ob_post.post(null, "SelectDir", function () { });
		    }
		    function ob_OnNodeSelect(sender, args) {
		        var value = args.node.id;
		        var parent = sender.getParentNode(args.node);
		        while (parent != null) {
		            value = parent.id + '/' + value;
		            parent = sender.getParentNode(parent);
		        }
		        SelectDir(value);
		    }
		</script>
		<style type="text/css">
			.tdText {
				font:11px Verdana;
				color:#333333;
			}
			.option2{
				font:11px Verdana;
				color:#0033cc;				
				padding-left:4px;
				padding-right:4px;
			}
			a {
				font:11px Verdana;
				color:#315686;
				text-decoration:underline;
			}

			a:hover {
				color:crimson;
			}
			
			.ob_spl_rightpanelcontent
			{
			    position: relative;
			}
		</style>
	</head>
	<body>
		<form id="Form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
		<table border="0">
			<tr>
				<td valign="top" class="h5">	            			            
					<div style="border:1px solid gray;width:680px;height:370px;">
						<div style="width:680px;height:370px;">
							<spl2:Splitter id="sp1" runat="server" StyleFolder="../Splitter/styles/default">
								<LeftPanel WidthDefault="169" WidthMin="169" WidthMax="350">
									<Header height="30">
										<div style="padding-left:10px;padding-top:5px;padding-bottom:5px;background-color:#C0C0C0" class="tdText">
											<b style="font-size:12px">Folders</b>
										</div>
									</Header>
									<Content>
										<div style="padding-top:7px;padding-left:10px;border-top:1px solid gray">
                                            <obout:Tree ID="ObTree" runat="server" OnNodeSelect="ob_OnNodeSelect">
                                            </obout:Tree>
										</div>
									</Content>
								</LeftPanel>
								<RightPanel>
									<Content>
										<div style="padding-top:0px;padding-left:0px;">
											<oajax:CallbackPanel id="cpDir" runat="server">
												<content>
													<ogrid:Grid id="gridDir" runat="server" AllowRecordSelection="true" ShowFooter="true"
													    AllowPaging="false" AllowPageSizeSelection="false"
														KeepSelectedRecords="false" AllowAddingRecords="false" CallbackMode="true" Serialize="true" 
														AllowColumnResizing="true" ShowHeader="true" 
														PageSize="100" FolderStyle="styles/premiere_blue" AutoGenerateColumns="false">
														<Columns>
															<ogrid:Column ID="Column1" DataField="imageType" HeaderText="" Align="center" Width="75" runat="server">
															    <TemplateSettings TemplateID="tplImageType" />
															</ogrid:Column>
															<ogrid:Column ID="Column2" DataField="Name" HeaderText="Name" Width="120" runat="server" />
															<ogrid:Column ID="Column3" DataField="Size" HeaderText="Size" Width="80" runat="server">
															    <TemplateSettings TemplateID="tplSize" />
															</ogrid:Column>
															<ogrid:Column ID="Column4" DataField="Type" HeaderText="Type" Width="83" runat="server" />
															<ogrid:Column ID="Column5" DataField="DateModified" HeaderText="Date Modified" Width="167" runat="server" />
														</Columns>	
														<Templates>
															<ogrid:GridTemplate runat="server" ID="tplImageType">
																<Template>
																    <img src="resources/images/filebrowser/<%# Container.Value %>.gif" />
																</Template>
															</ogrid:GridTemplate>
															<ogrid:GridTemplate runat="server" ID="tplSize">
																<Template>
																	<div style="width:100%;height:100%;padding-left:10px;padding-top:6px">
																		<%#Container.Value + " KB"%>
																	</div>
																</Template>
															</ogrid:GridTemplate>
														</Templates>
													</ogrid:Grid>	
												</content>
												<loading>
													<table width=100% height=100% cellpadding=0 cellspacing=0>
														<tr>
															<td align=center>
																<img src="resources/loading_icons/1.gif">
															</td>
														</tr>
													</table>
												</loading>
											</oajax:CallbackPanel>
											<oajax:CallbackPanel id="cpLabel" runat="server">
												<content>
													<asp:Label id="lblDir" runat="server" />
												</content>
											</oajax:CallbackPanel>
										</div>
									</Content>
								</RightPanel>
							</spl2:Splitter>
						</div>
					</div>
				</td>	
			</tr>
		</table>
		
		<br /><br /><br />
		
		<a href="Default.aspx?type=VBNET">« Back to examples</a>
		
		</form>
	</body>
</html>
