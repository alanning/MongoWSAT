<%@ Control Language="C#" AutoEventWireup="True" Inherits="UserControls_adminSideNavigation" Codebehind="adminSideNavigation.ascx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%-- ajax script manager --%>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>

<%-- ajax accordion --%>
<cc1:Accordion ID="MyAccordion" runat="server" SelectedIndex="0" HeaderCssClass="accordionHeader"
    ContentCssClass="accordionContent" FadeTransitions="true" FramesPerSecond="60"
    TransitionDuration="400" AutoSize="Limit">
    <Panes>
        <cc1:AccordionPane ID="AccordionPane1" runat="server">
            <Header>
                <a href="" onclick="return false;"><img src="../../App_Themes/Default/Images/nav-Expand.gif" alt="Membership" border="0px" align="right" />Membership</a>
            </Header>
            <Content>
                <div class="accordionLink">
                    <a href="default.aspx">Registered Users</a>
                </div>
                <div class="accordionLink">
                    <a href="add_user.aspx">Add New Users</a>
                </div>
                <div class="accordionLink">
                    <a href="search_user.aspx">Search Users</a>
                </div>
                <div class="accordionLink">
                    <a href="roles.aspx">Role Management</a>
                </div>
                <div class="accordionLink">
                    <a href="access_rules.aspx">Access Rules</a>
                </div>
                <div class="accordionLink">
                    <a href="Quick_contact.aspx?letter=none">Quick Email</a>
                </div>
                <div class="accordionImage1">
                    
                </div>
            </Content>
        </cc1:AccordionPane>
        <cc1:AccordionPane ID="AccordionPane2" runat="server">
            <Header>
                <a href="" onclick="return false;"><img src="../../App_Themes/Default/Images/nav-Expand.gif" alt="Membership" border="0px" align="right" />Section 2</a>
            </Header>
            <Content>
                <div class="accordionLink">
                    <a href="#">Category Link</a>
                </div>
                <div class="accordionImage2">
                    
                </div>
            </Content>
        </cc1:AccordionPane>
        <cc1:AccordionPane ID="AccordionPane3" runat="server">
            <Header>
                <a href="" onclick="return false;"><img src="../../App_Themes/Default/Images/nav-Expand.gif" alt="Membership" border="0px" align="right" />Section 3</a>
            </Header>
            <Content>
                <div class="accordionLink">
                    <a href="#">Category Link</a>
                </div>
                <div class="accordionImage2">
                    
                </div>
            </Content>
        </cc1:AccordionPane>
        <cc1:AccordionPane ID="AccordionPane4" runat="server">
            <Header>
                <a href="" onclick="return false;"><img src="../../App_Themes/Default/Images/nav-Expand.gif" alt="Membership" border="0px" align="right" />Section 4</a>
            </Header>
            <Content>
                <div class="accordionLink">
                    <a href="#">Category Link</a>
                </div>
                <div class="accordionImage2">
                    
                </div>
            </Content>
        </cc1:AccordionPane>
    </Panes>
</cc1:Accordion>

