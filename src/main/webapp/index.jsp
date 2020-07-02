<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RiceOJ</title>

<c:import url="link.jsp"></c:import>
</head>

<body>
<c:import url="header.jsp"></c:import>
<div class="container-fixed">
	<div class="row">
		<div class="col-xs-9">
			<article class="article">
				<header>
					<h1 class="text-center">About Rice Online Judge</h1>
					<section class="abstract">
						<p>RiceOJ部署于云服务器(Ubuntu18.04系统)中，采用SSM框架进行开发。目前支持C、C++、JAVA、Python2语言进行提交。</p>
					</section>
				</header>
				<section class="content">
					<h2 class="text-center">Q & A</h2>
						<p><span style="color: green; ">Q</span>:程序怎样取得输入、进行输出？<br>
							<span style="color: red; ">A</span>:你的程序应该从标准输入 stdin('Standard Input')获取输入，并将结果输出到标准输出 stdout('Standard Output')。例如,在C语言可以使用 'scanf' ，在C++可以使用'cin' 进行输入；在C使用 'printf' ，在C++使用'cout'进行输出。</p>
						<p>用户程序不允许直接读写文件, 如果这样做可能会判为运行时错误 "<span style="color: green; ">Runtime Error</span>"。<br>
							<br>
							下面是题目1000的参考答案</p>
						<p> C++:<br>
						</p>
						<pre class="prettyprint">
#include &lt;iostream&gt;
using namespace std;
int main(){
    int a,b;
    while(cin &gt;&gt; a &gt;&gt; b)
        cout &lt;&lt; a+b &lt;&lt; endl;
    return 0;
}
</pre>
						C:<br>
					<pre class="prettyprint">
#include &lt;stdio.h&gt;
int main(){
    int a,b;
    while(scanf("%d %d",&amp;a, &amp;b) != EOF)
        printf("%d\n",a+b);
    return 0;
}
</pre>
						Java:<br>
						<pre class="prettyprint">
import java.util.*;
public class Main{
	public static void main(String args[]){
		Scanner cin = new Scanner(System.in);
		int a, b;
		while (cin.hasNext()){
			a = cin.nextInt(); b = cin.nextInt();
			System.out.println(a + b);
		}
	}
}</pre>
					Python:<br>
					<pre class="prettyprint">
while True:
	try:
	a, b = map(int, input().split())
	print(a+b)
	except:
	break
	pass
}</pre>


					<hr>
					<span style="color: green; ">Q</span>:为什么我的程序在自己的电脑上正常编译，而系统告诉我编译错误？<br>
					<span style="color: red; ">A</span>:GCC的编译标准与VC6有些不同，更加符合c/c++标准：<br>
					<ul>
						<li><span style="color: blue; ">main</span> 函数必须返回<span style="color: blue" >int</span>, <span
								style="color:blue">void main</span> 的函数声明会报编译错误。<br>
						</li>
						<li><span style="color:green">i</span> 在循环外失去定义 "<span style="color:blue">for</span>(<span
								style="color:blue" >int</span> <span style="color:green" >i</span>=0...){...}"<br>
						</li>
						<li><span style="color:green" >itoa</span> 不是ansi标准函数。<br>
						</li>
						<li><span style="color:green" >__int64</span> 不是ANSI标准定义，只能在VC使用, 但是可以使用<span
								style="color:blue" >long long</span>声明64位整数。<br>如果用了__int64,试试提交前加一句#define __int64 long long,
							scanf和printf 请使用%lld作为格式
						</li>
					</ul>
					<hr>
					<span style="color: green">Q</span>:系统返回信息都是什么意思？<br>
					<span style="color: red">A</span>:详见下述：<br>
					<p><span class='text-muted'>Pending</span> : 系统忙，你的答案在排队等待。<br></p>
					<p><span class='text-brown'>Compiling</span> : 正在编译。<br></p>
					<p><span class='text-info'>Running &amp; Judging</span>: 正在运行和判断。<br></p>
					<p><span class="text-success">Accepted</span> : 程序通过！<br></p>
					<p><span class='text-danger'>Wrong Answer</span> : 答案不对，仅仅通过样例数据的测试并不一定是正确答案，一定还有你没想到的地方。<br></p>
					<p><span class='text-warning'>Presentation Error</span> : 答案基本正确，但是格式不对。<br></p>
					<p><span class='text-warning'>Time Limit Exceeded</span> : 运行超出时间限制，检查下是否有死循环，或者应该有更快的计算方法。<br></p>
					<p><span class='text-warning'>Memory Limit Exceeded</span> : 超出内存限制，数据可能需要压缩，检查内存是否有泄露。<br></p>
					<p><span class='text-warning'>Output Limit Exceeded</span>: 输出超过限制，你的输出比正确答案长了两倍.<br></p>
					<p><span class='text-special'>Runtime Error</span> : 运行时错误，非法的内存访问，数组越界，指针漂移，调用禁用的系统函数。请点击后获得详细输出。<br></p>
					<p><span class='text-primary'>Compile Error</span> : 编译错误，请点击后获得编译器的详细输出。<br></p>
					<hr>
					<span style="color:green" >Q</span>:如何参加在线比赛?<br>
					<span style="color:red" >A</span>:<a href="register.jsp">注册</a>
					一个帐号，然后就可以练习，点击比赛列表Contests可以看到正在进行的比赛并参加。<br>
					<br>
				</section>
			</article>
		</div>
		<div class="col-xs-3">
			<c:choose>
				<c:when test="${not empty sessionScope.User}">
					<div class="panel-group" id="accordionPanels" aria-multiselectable="true">
						<br>
						<img src="default2.jpg" width="70px" height="70px" class="img-circle center-block" alt="圆形图片">
						<h2 class="text-center">${sessionScope.User.user_id}</h2>
						<div class="panel panel-default">
							<div class="panel-heading" id="headingOne">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordionPanels" href="#collapseOne">
										个人信息
									</a>
								</h4>
							</div>
							<div id="collapseOne" class="panel-collapse collapse in">
								<div class="panel-body">
									<table >
										<tr class="row">
											<td class="col-xs-4">提交数：</td>
											<td class="col-xs-8">${sessionScope.User.rankUser.submit}</td>
										</tr>
										<tr class="row">
											<td class="col-xs-4">通过数：</td>
											<td class="col-xs-8">${sessionScope.User.rankUser.solve}</td>
										</tr>
										<tr class="row">
											<td class="col-xs-4">解决数：</td>
											<td class="col-xs-8">${sessionScope.User.rankUser.solved}</td>
										</tr>
										<tr class="row">
											<td class="col-xs-4">通过率：</td>

											<td class="col-xs-8"><fmt:formatNumber type="number"
																				   value="${sessionScope.User.rankUser.pass_rate * 100}"
																				   pattern="0.0" maxFractionDigits="1"/>%</td>
										</tr>
										<tr class="row">
											<td class="col-xs-4">排&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
											<td class="col-xs-8">${sessionScope.User.rankUser.rank}</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading" id="headingTwo">
								<h4 class="panel-title">
									<a class="collapsed" data-toggle="collapse" data-parent="#accordionPanels" href="#collapseTwo">
										提交过
									</a>
								</h4>
							</div>
							<div id="collapseTwo" class="panel-collapse collapse">
								<div class="panel-body">
									<div class="cards">
										<p>题号:</p>
										<c:forEach var="problem_id" items="${sessionScope.User.sub_problems}">
											<div class="col-md-4 col-sm-6 col-lg-3">
												<a href="${ptx}/problem?problem_id=${problem_id}">${problem_id}</a>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading" id="headingThree">
								<h4 class="panel-title">
									<a class="collapsed" data-toggle="collapse" data-parent="#accordionPanels" href="#collapseThree">
										参加过
									</a>
								</h4>
							</div>
							<div id="collapseThree" class="panel-collapse collapse">
								<div class="panel-body">
									<p>比赛:</p>
									<c:forEach var="contest" items="${sessionScope.User.rg_contests}">
										<tr>
											<td class="text-ellipsis">
												<a href="${ptx}/contest?contest_id=${contest.contest_id}">${contest.title}</a>
											</td>
										</tr>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise><br>
					<img src="default.jpg" width="70px" height="70px" class="img-circle center-block" alt="圆形图片">
					<h3 class="text-center">未<a href="login.jsp">登录</a></h3>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<c:import url="footer.jsp"></c:import>
<script>
	prettifyLoad();
</script>
</body>
</html>