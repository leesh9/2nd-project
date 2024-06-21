<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="/jsp/common/header.jsp"%> 
<div class="search-group">
    <h2>상품 리스트</h2>
  <form class="search-bar">
  	<select name="productPerBlock" id="productPerBlock">
  		<option value="6">6개씩 보기</option>
  		<option value="12">12개씩 보기</option>
  		<option value="18">18개씩 보기</option>
  	</select>
    <input type="text" id="searchProductName" name="searchValue" placeholder="Search..." />
    <button type="button" class="search-btn" id="searchBtn">&#128269;</button>
  </form>
</div>
<div class="product-list" id="productList">
	<div class="item-list">
		<c:forEach var="product" items="${requestScope.p_ar}" varStatus="i">
			<div class="item">
				<div class="img-box">
					<img src="${pageContext.request.contextPath}/img/${product.pd_thumbnail_img}"
						alt="${product.pd_name }">
				</div>
				<p>[왕밤빵 베이커리]${product.pd_name}</p>
				<p>${product.pd_price}만원</p>
			</div>
		</c:forEach>
	</div>
</div>

  <div class="pagination" id="pagination">
    <c:set var="paging" value="${requestScope.paging}" />
    <c:choose>
    	<c:when test="${paging.nowPage > 1 }">
		    <div><a href="?type=item&cPage=${paging.nowPage-1}">&lt;</a></div>
    	</c:when>
    	<c:when test="${paging.nowPage <= 1 }">
		    <div class="disable">&lt;</div>
    	</c:when>
    </c:choose>
    <c:forEach begin="${paging.startPage }" end="${paging.endPage}" varStatus="st">
    	<c:choose>
	    	<c:when test="${paging.nowPage != st.index }">
			    <div><a href="?type=item&cPage=${st.index}">${st.index}</a></div>
	    	</c:when>
	    	<c:when test="${paging.nowPage == st.index }">
			    <div class="on"><a href="?type=item&cPage=${st.index}">${st.index}</a></div>
	    	</c:when>
    	</c:choose>
    </c:forEach>
    <c:choose>
    	<c:when test="${paging.nowPage < paging.endPage }">
		    <div><a href="?type=item&cPage=${paging.nowPage+1}">&gt;</a></div>
    	</c:when>
    	<c:when test="${paging.nowPage >= paging.endPage }">
		    <div class="disable">&gt;</div>
    	</c:when>
    </c:choose>
  </div>

  <div class="btn_div">
    <button type="button" class="btn submit">삭제</button>
  </div>
  
 <%@include file="/jsp/common/footer.jsp"%>
 
  <script>
	  $(function() {
	      $("#searchBtn").on('click', function() {
	          const searchValue = $("#searchProductName").val();
	          const productPerBlock = $("#productPerBlock").val();
	          const cPage = $(".on").text();
	          const param = {
        		  "type":"item",
        		  "searchValue": searchValue,
        		  "productPerBlock":productPerBlock,
	          }
	          
	          $.ajax({
	              url: "?",  // 올바른 서블릿 경로를 지정하세요.
	              type: "GET",
	              data: param,
	          }).done(function(res){
	        	  $("#productList").html($(res).find("#productList").html());
	        	  $("#pagination").html($(res).find("#pagination").html());
	          });
	      });
	  });
  </script>
 </body>

</html>