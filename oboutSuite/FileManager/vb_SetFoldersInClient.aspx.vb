Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Obout.Ajax.UI


Partial Class FileManager_vb_SetFoldersInClient
    Inherits System.Web.UI.Page
    Protected Sub fileselected_postback(sender As Object, e As EventArgs)
        Dim manager As Obout.Ajax.UI.FileManager.FileManager = TryCast(sender, Obout.Ajax.UI.FileManager.FileManager)
        Result.Controls.Clear()
        Result.Controls.Add(New LiteralControl("<br /><b>Selected image:</b><br /><br />"))

        Dim image As New Image()
        image.ImageUrl = manager.FileUrl
        Dim width As Integer, height As Integer
        getWidthAndHeight(Integer.Parse(manager.FileWidth), Integer.Parse(manager.FileHeight), width, height)
        image.Width = New Unit(width, UnitType.Pixel)
        image.Height = New Unit(height, UnitType.Pixel)

        Result.Controls.Add(image)
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

End Class
