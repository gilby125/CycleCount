Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Obout.Ajax.UI

Partial Public Class FileManager_vb_DifferentUsers
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If UserName.Value.Length > 0 Then
            Dim folder As String = "Images/" + UserName.Value
            imageBrowser.GalleryFolders = folder
            imageBrowser.ManagedFolders = folder
            imageBrowser.GalleryNames = UserName.Value
        End If
    End Sub

    Protected Sub OpenManager(sender As Object, e As EventArgs)
        ScriptManager.RegisterStartupScript(Me, Me.[GetType](), "response", "openManager()", True)
    End Sub

    Protected Sub fileselected_postback(sender As Object, e As EventArgs)
        Dim manager As Obout.Ajax.UI.FileManager.FileManager = TryCast(sender, Obout.Ajax.UI.FileManager.FileManager)
        If manager.FileUrl.Length > 0 Then
            ' if not disabled in client-side
            Result.Controls.Clear()
            Result.Controls.Add(New LiteralControl("<br /><b>Selected image:</b><br /><br />"))

            Dim image As New Image()
            image.ImageUrl = manager.FileUrl
            Dim width As Integer, height As Integer
            getWidthAndHeight(Integer.Parse(manager.FileWidth), Integer.Parse(manager.FileHeight), width, height)
            image.Width = New Unit(width, UnitType.Pixel)
            image.Height = New Unit(height, UnitType.Pixel)
            image.AlternateText = manager.FileTitle
            image.ToolTip = manager.FileTitle

            Result.Controls.Add(image)
        End If
    End Sub

    Shared maxWidth As Integer = 300
    Shared maxHeight As Integer = 200
    Private Sub getWidthAndHeight(imageWidth As Integer, imageHeight As Integer, ByRef width As Integer, ByRef height As Integer)
        width = imageWidth
        height = imageHeight

        If width > maxWidth Then
            height = CInt(Math.Truncate(CDbl(height) * (CDbl(maxWidth) / CDbl(width))))
            width = maxWidth
        End If
        If height > maxHeight Then
            width = CInt(Math.Truncate(CDbl(width) * (CDbl(maxHeight) / CDbl(height))))
            height = maxHeight
        End If

        If height = 0 Then
            height = 5
        End If
        If width = 0 Then
            width = 5
        End If
    End Sub
    Private Shared Function InlineAssignHelper(Of T)(ByRef target As T, value As T) As T
        target = value
        Return value
    End Function
End Class
