<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(function () {
        $("li>a").click(function () {
            var number=$(this).attr("number");
            var url=location.href;
            var url1=url.split("?")[0];
            location.href =url1+"?pageNum="+number+"&pageSize=3";
        })
    })
</script>
<div class="row">
    <div class="col-lg-4 col-lg-offset-2">
        <h4>共 条记录，共 页，当前 页</h4>
    </div>
    <div class="col-lg-6">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li <c:if test="${pageInfo.isFirstPage}">class="disabled" </c:if>>
                    <c:if test="${pageInfo.isFirstPage}">
                        <span  >首页</span>
                    </c:if>
                    <c:if test="${pageInfo.isFirstPage==false}">
                        <a href="#"number="1">首页</a>
                    </c:if>
                </li>

                <li <c:if test="${pageInfo.hasPreviousPage==false}">class="disabled"</c:if>>
                    <c:if test="${pageInfo.hasPreviousPage==false}">
                        <span>
                            <span aria-hidden="true">&laquo;</span>
                        </span>
                    </c:if>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <a href="#" aria-label="Previous" number="${pageInfo.prePage}">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </c:if>
                </li>
                <c:forEach items="${pageInfo.navigatepageNums}" var="number">
                    <li <c:if test="${pageInfo.pageNum==number}" >class="active"</c:if>><a href="#" number="${number}">${number}</a></li>
                </c:forEach>
                <li <c:if test="${pageInfo.hasNextPage==false}">class="disabled"</c:if> >
                    <c:if test="${pageInfo.hasNextPage==false}">
                        <span >
                            <span aria-hidden="true">&raquo;</span>
                        </span>
                    </c:if>
                    <c:if test="${pageInfo.hasNextPage}">
                        <a href="#" aria-label="Next" number="${pageInfo.nextPage}">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </c:if>
                </li>
                <li <c:if test="${pageInfo.isLastPage}" >class="disabled"</c:if>>
                    <c:if test="${pageInfo.isLastPage}">
                        <span >末页</span>
                    </c:if>
                    <c:if test="${pageInfo.isLastPage==false}">
                        <a href="#" number="${pageInfo.pages}">末页</a>
                    </c:if>

                </li>
            </ul>
        </nav>
    </div>
</div>


