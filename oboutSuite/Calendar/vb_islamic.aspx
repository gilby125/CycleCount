<%@ Page Language="VB" AutoEventWireup="true" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_NET" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected calDefault As OboutInc.Calendar2.Calendar

    Private Sub Page_Load(o As Object, e As EventArgs)
	    DefaultPlaceholder.Controls.Add(calDefault)
    End Sub

    Private Sub Page_Init(o As Object, e As EventArgs)
	    calDefault = New OboutInc.Calendar2.Calendar()
	    calDefault.ID = "calDefault"
        calDefault.CultureName = "ar-SA"
        'calDefault.ShortDayNames = "Su,Mo,Tu,We,Th,Fr,Sa"
        'calDefault.FullMonthNames = "Muharram,Safar,Rabi' al-awwal,Rabi' al-thani,Jumada al-awwal,Jumada al-thani,Rajab,Sha'ban,Ramadan,Shawwal,Dhu al-Qi'dah,Dhu al-Hijjah"
        calDefault.MonthWidth = 300
    End Sub
</script>
<html>
	<head>
		<title>obout ASP.NET Calendar examples</title>

	    <style type="text/css">
			
			.tdText {
                font:11px Verdana;
                color:#333333;
            }
			body {
				font:11px Verdana;
				color:#333333;
			}
			a {
				font:11px Verdana;
				color:#315686;
				text-decoration:underline;
			}
			a:hover {
				color:crimson;
			}
		</style>
	</head>
	<body>
		<form id="Form1" runat="server">
	        <span class="tdText"><b>ASP.NET Calendar - Lunar Islamic(Hijri) calendar</b></span>
		    <br /><br />	
			<br /><br /> 
			<ASP:PlaceHolder runat="server" id="DefaultPlaceholder"></ASP:PlaceHolder>
			<br /><br /><br /><br /><br />
			<a style="font-size:10pt;font-family:Tahoma" href="Default.aspx?type=VBNET">« Back to examples</a>
		</form>
	</body>
</html>