<%@ Master Language="C#" AutoEventWireup="True" Inherits="Admin_MasterPage" Codebehind="MasterPage.master.cs" %>
<%@ Register src="~/Users/UserControls/adminHeader.ascx" tagname="adminHeader" tagprefix="uc1" %>
<%@ Register src="~/Users/UserControls/adminFooter.ascx" tagname="adminFooter" tagprefix="uc2" %>
<%@ Register src="~/Users/UserControls/adminSideNavigation.ascx" tagname="adminSideNavigation" tagprefix="uc3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    
    <%-- favicon setup --%>
    <link id="Link3" runat="server" rel="shortcut icon" href="~/favicon.ico" type="image/x-icon" />
    <link id="Link4" runat="server" rel="icon" href="~/favicon.ico" type="image/ico" />
    
    <asp:ContentPlaceHolder id="head" runat="server">
    </asp:ContentPlaceHolder>
</head>
<body>
    <form id="form1" runat="server">
    
    <%-- header user control include --%>
    <uc1:adminHeader ID="header1" runat="server" />
        
        <%-- div navigation wrap --%>
        <div class="adminNavigationWrap">
        
            <%-- side navigation include --%>
            <uc3:adminSideNavigation ID="adminSideNavigation1" runat="server" />
            
        </div>

        <%-- div entire page content wrap --%>
        <div class="adminContentWrap">
        
        <%-- div content body title wrap --%>
        <div class="formHeaderDiv">
        
            <%-- content body title edit region --%>
            <asp:ContentPlaceHolder ID="cphBodyTitle" runat="server">
            
            </asp:ContentPlaceHolder>
            
        </div>
        
        <%-- user category buttons wrap --%>
        <div class="userCategoriesWrap">
        
            <asp:ContentPlaceHolder ID="cphUserNavigation" runat="server">
            </asp:ContentPlaceHolder>
            
        </div>
        
        <%-- form content body wrap --%>
        <div class="formOutlineDiv">
        
            <asp:ContentPlaceHolder ID="cphContentBody" runat="server">
            </asp:ContentPlaceHolder>
            
        </div>
        
        </div>
    
    <%-- footer user control include --%>
    <uc2:adminFooter ID="footer1" runat="server" />
    
    </form>
</body>
</html>
