<%@page import="com.plzdaeng.group.model.GroupMember"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<% List<GroupMember> list = (List)request.getAttribute("memberlist");
int x = 1;
  %>
  <% for(GroupMember member : list){
	  %>
 						
						 <tr>
                          <th scope="row"><%=x %>
                          <input type="hidden" name="member_status" value="<%=member.getMember_status()%>"></th>
                          
                          <td>
                          <%if(member.getMember_status().equals("M")){
                        	  %>일반<%
                          }else if(member.getMember_status().equals("L")){
                        	  %>모임장<%
                          }else if(member.getMember_status().equals("A")){
                        	  %>가입요청<%
                          }%>
                          </td>
                          <td class="member_id"><%= member.getUser_id() %></td>
	                      <td><%= member.getNickName() %></td>
                          
                          <td><%=member.getGroup_joindate() %></td>
                          <td><button type="button">
                          <%if(member.getMember_status().equals("M")){
                        	  %>추방<%
                          }else if(member.getMember_status().equals("L")){
                        	  %>모임장위임<%
                          }else if(member.getMember_status().equals("A")){
                        	  %>가입승인<%
                          }%>
                          </button></td>
                        </tr>
                        
<%x++; }%>