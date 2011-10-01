<%@ Page Language="C#" AutoEventWireup="True" Inherits="Goodies_CollapsablePanel" Codebehind="CollapsablePanel.aspx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Untitled Page</title>
</head>

<body>
    <form id="form1" runat="server">    
    <div>
    
        <%-- ajax script manager --%>
        <asp:scriptmanager id="ScriptManager1" runat="server">
        </asp:scriptmanager>
        
        <%-- ajax collapsable panel --%>
        <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" ExpandControlID="pnl_Title"
            CollapseControlID="pnl_Title" TargetControlID="pnl_Content" Collapsed="true"
            TextLabelID="lbl_Expand" ExpandedText="( ..hide help... )" CollapsedText="( ..show help... )"
            ImageControlID="img_expand" CollapsedImage="~/App_Themes/Default/images/expand.jpg"
            ExpandedImage="~/App_Themes/Default/images/collapse.jpg" SuppressPostBack="true">
        </cc1:CollapsiblePanelExtender>
        <asp:Panel ID="pnl_Title" runat="server" CssClass="CollapsePanelHeader">
            &nbsp;&nbsp;
            <asp:Image ID="img_expand" runat="server" ImageUrl="~/App_Themes/Default/images/expand.jpg" />
            &nbsp;
            <asp:Label ID="lbl_expand" runat="server" Text="Label">expand to view help</asp:Label>
        </asp:Panel>
        <asp:Panel ID="pnl_Content" runat="server" CssClass="CollapsePanel">
            <div class="CollapseHelpHints">
                text goes here
            </div>
        </asp:Panel>
        
    </div>  
    </form>
</body>
</html>
