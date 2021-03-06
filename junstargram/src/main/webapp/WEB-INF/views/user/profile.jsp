<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photogram</title>
    <!-- Style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profile.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap"
        rel="stylesheet">
</head>

<body>

    <header class="header">
        <div class="container">
            <a href="${pageContext.request.contextPath}/insta/feed" class="logo"><img src="${pageContext.request.contextPath}/resources/images/junsta.png" alt=""></a>
            <nav class="navi">
                <ul class="navi-list">
                    <li class="navi-item"><a href="${pageContext.request.contextPath}/insta/feed">
							<i class="fas fa-home"></i>
						</a></li>
					<li class="navi-item"><a href="${pageContext.request.contextPath}/resources/explore">
							<i class="far fa-compass"></i>
						</a></li>
					<li class="navi-item"><a href="${pageContext.request.contextPath}/insta/user/${principal.user.id}">
							<i class="far fa-user"></i>
						</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="profile">
        <div class="container">
            <div class="profile-left">
                <div class="profile-img-wrap story-border" onclick="popup('.modal-image')">
                    <img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt="">
                    <svg viewbox="0 0 110 110">
                        <circle cx="55" cy="55" r="53" />
                    </svg>
                </div>
            </div>
            <div class="profile-right">
                <div class="name-group">
                	<%-- ${#id} --%>
                    <h2>id</h2>
                    <button class="cta" onclick="location.href='/insta/uploadAjax'">??? ??? ???</button>
                    <button class="cta">????????? ??????</button>
                    <button class="modi" onclick="popup('.modal-info')"><i class="fas fa-cog"></i></button>
                </div>
                <div class="follow">
                    <ul>
                        <li><a href="">?????????<span>6</span></a> </li>
                        <li><a href="" id="subscribeBtn">?????????<span>2650</span></a> </li>
                        <li><a href="" id="subscribeBtn">?????????<span>106</span></a> </li>
                    </ul>
                </div>
                <div class="state">
                    <h4>intro</h4>
                </div>
            </div>
        </div>
    </section>

    <div class="gallery">
        <div class="container">
            <div class="controller">      
            </div>
        </div>
    </div>

    <section id="tab-content">
        <div class="container">
            <div id="tab-1-content" class="tab-content-item show">
                <div class="tab-1-content-inner">
                    <div class="img-box">
                        <a href=""><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


      <footer>
        <div class="container">
            <ul>
                <li><a href="#a">??????</a></li>
                <li><a href="#a">?????????</a></li>
                <li><a href="#a">?????? ??????</a></li>
                <li><a href="#a">?????????</a></li>
                <li><a href="#a">API</a></li>
                <li><a href="#a">????????????????????????</a></li>
                <li><a href="#a">??????</a></li>
                <li><a href="#a">?????? ??????</a></li>
                <li><a href="#a">????????????</a></li>
                <li><a href="#a">??????</a></li>
            </ul>
            <div class="copy">
                <p>??? 2020 Photogram from There Programing</p>
            </div>
        </div>
    </footer>

    <div class="modal-info">
        <div class="modal">
            <button onclick="location.href='profileSetting.html'">???????????????????????? ????????????</button>
            <button>????????????????????????</button>
            <button onclick="closePopup('.modal-info')">????????????</button>
        </div>
    </div>

    <div class="modal-image">
        <div class="modal">
            <p>?????????????????? ???????? ???????????????</p>
            <button>???????? ??????????????????</button>
            <button onclick="closePopup('.modal-image')">????????????</button>
        </div>
    </div>

    <div class="modal-follow">
        <div class="follower">
            <div class="follower-header">
                <span>???????????????????????</span>
                <button onclick="closeFollow()"><i class="fas fa-times"></i></button>
            </div>
            <div class="follower-list">
                <div class="follower__item">
                    <div class="follower__img"><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></div>
                    <div class="follower__text">
                        <h2>??????????????????</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">???????????????????????</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></div>
                    <div class="follower__text">
                        <h2>??????????????????</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">???????????????????????</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></div>
                    <div class="follower__text">
                        <h2>??????????????????</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">???????????????????????</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></div>
                    <div class="follower__text">
                        <h2>??????????????????</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">???????????????????????</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></div>
                    <div class="follower__text">
                        <h2>??????????????????</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">???????????????????????</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></div>
                    <div class="follower__text">
                        <h2>??????????????????</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">???????????????????????</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></div>
                    <div class="follower__text">
                        <h2>??????????????????</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">???????????????????????</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="${pageContext.request.contextPath}/resources/images/macho.jpg" alt=""></div>
                    <div class="follower__text">
                        <h2>??????????????????</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">???????????????????????</button></div>
                </div>

            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/profile.js"></script>
</body>

</html>