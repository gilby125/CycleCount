Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Obout.Ajax.UI


Partial Public Class FileManager_vb_GetFileServerSide
    Inherits System.Web.UI.Page
    Protected Sub fileselected_postback(sender As Object, e As EventArgs)
        Dim manager As Obout.Ajax.UI.FileManager.FileManager = TryCast(sender, Obout.Ajax.UI.FileManager.FileManager)
        Result.Controls.Clear()
        Result.Controls.Add(New LiteralControl("<br /><b>Parameters of the selected file</b><br />"))
        Dim table As New Table()
        table.CellSpacing = 3
        table.BorderWidth = New Unit(1, UnitType.Pixel)
        table.BorderColor = System.Drawing.Color.FromName("gray")
        Result.Controls.Add(table)

        table.Rows.Add(addRow("Url", manager.FileUrl, System.Drawing.Color.FromName("lightgray")))
        table.Rows.Add(addRow("Title", manager.FileTitle, System.Drawing.Color.FromName("white")))
        table.Rows.Add(addRow("Width", manager.FileWidth, System.Drawing.Color.FromName("lightgray")))
        table.Rows.Add(addRow("Height", manager.FileHeight, System.Drawing.Color.FromName("white")))
        table.Rows.Add(addRow("Info", manager.FileInfo, System.Drawing.Color.FromName("lightgray")))
        'table.Rows.Add(addRow("File picked", manager.FilePicked.ToString(), System.Drawing.Color.FromName("white")))
    End Sub

    Private Function addRow(name As String, value As String, backcolor As System.Drawing.Color) As TableRow
        Dim row As TableRow
        Dim cell As TableCell

        row = New TableRow()
        row.BackColor = backcolor
        cell = New TableCell()
        cell.HorizontalAlign = HorizontalAlign.Left
        row.Cells.Add(cell)
        cell.Controls.Add(New LiteralControl("<b>" & name & "</b>:"))
        cell = New TableCell()
        cell.HorizontalAlign = HorizontalAlign.Left
        row.Cells.Add(cell)
        cell.Controls.Add(New LiteralControl(value))
        Return row
    End Function
End Class
