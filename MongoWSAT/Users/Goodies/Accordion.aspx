<%@ Page Language="C#" AutoEventWireup="True" Inherits="Goodies_Accordian" Codebehind="Accordion.aspx.cs" %>
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
        
        <%-- ajax accordion --%>
        <cc1:accordion ID="MyAccordion" runat="server" 
                           SelectedIndex="0" 
                           HeaderCssClass="accordionHeader" 
                           ContentCssClass="accordionContent" 
                           FadeTransitions="true" 
                           FramesPerSecond="40" 
                           TransitionDuration="250"
                           AutoSize="None">
     <Panes>
          <cc1:AccordionPane ID = "AccordionPane1" runat = "server">
          <Header>
            <a href = "" onclick = "return false;" class = "accordionLink"> Section 1</a>
          </Header>
          <Content>
            <p>gdhfghdfghdfgdhf</p>
          </Content>
        </cc1:AccordionPane>

        <cc1:AccordionPane ID = "AccordionPane2" runat = "server">
          <Header>
            <a href = "" onclick = "return false;" class = "accordionLink"> Section 2</a>
          </Header>
          <Content>
            <p>gdhfghdfghdfgdhf</p>
          </Content>
        </cc1:AccordionPane>

        <cc1:AccordionPane ID = "AccordionPane3" runat = "server">
          <Header>
            <a href = "" onclick = "return false;" class = "accordionLink"> Section 3</a>
          </Header>
          <Content>
            <p>gdhfghdfghdfgdhf</p>
          </Content>
        </cc1:AccordionPane>

        <cc1:AccordionPane ID = "AccordionPane4" runat = "server">
          <Header>
            <a href = "" onclick = "return false;" class = "accordionLink"> Section 4</a>
          </Header>
          <Content>
           <p>gdhfghdfghdfgdhf</p>
          </Content>
        </cc1:AccordionPane>
     </Panes>
     </cc1:accordion>
        
    </div>  
    </form>
</body>
</html>
