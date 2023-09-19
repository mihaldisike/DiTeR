// Designs

$(function () {
    $(".sidebar-link").click(function () {
        $(".sidebar-link").removeClass("is-active");
        $(this).addClass("is-active");
    });
});

$(window)
        .resize(function () {
            if ($(window).width() > 1090) {
                $(".sidebar").removeClass("collapse");
            } else {
                $(".sidebar").addClass("collapse");
            }
        })
        .resize();

const allVideos = document.querySelectorAll(".video");

allVideos.forEach((v) => {
    v.addEventListener("mouseover", () => {
        const video = v.querySelector("video");
        video.play();
    });
    v.addEventListener("mouseleave", () => {
        const video = v.querySelector("video");
        video.pause();
    });
});

$(function () {
    $(".logo, .logo-expand, .discover").on("click", function (e) {
        $(".main-container").removeClass("show");
        $(".main-container").scrollTop(0);
    });
    $(".checks, .apply").on("click", function (e) {
        $(".main-container").addClass("show");
        $(".main-container").addClass("hide-options");
        $(".main-container").removeClass("hide-results");
        $(".main-container").scrollTop(0);
        $(".sidebar-link").removeClass("is-active");
        $(".checks").addClass("is-active");
    });

    $(".new-chroot").click(function () {
        $(".main-container").addClass("show");
        $(".set-new-chroot").addClass("show");
        $(".set-chroot").removeClass("show");
        $(".set-phpfpm").removeClass("show");
        $(".set-nginxdomain").removeClass("show");
        $(".main-container").scrollTop(0);
        $(".sidebar-link").removeClass("is-active");
        $(".main-container").addClass("hide-results");
        $(".main-container").removeClass("hide-options");
        $(".new-chroot").addClass("is-active");
    });

    $(".chroot").click(function () {
        $(".main-container").addClass("show");
        $(".set-chroot").addClass("show");
        $(".set-new-chroot").removeClass("show");
        $(".set-phpfpm").removeClass("show");
        $(".set-nginxdomain").removeClass("show");
        $(".main-container").scrollTop(0);
        $(".sidebar-link").removeClass("is-active");
        $(".main-container").addClass("hide-results");
        $(".main-container").removeClass("hide-options");
        $(".chroot").addClass("is-active");
    });

    $(".phpfpm").click(function () {
        $(".main-container").addClass("show");
        $(".set-phpfpm").addClass("show");
        $(".set-chroot").removeClass("show");
        $(".set-new-chroot").removeClass("show");
        $(".set-nginxdomain").removeClass("show");
        $(".main-container").scrollTop(0);
        $(".sidebar-link").removeClass("is-active");
        $(".main-container").addClass("hide-results");
        $(".main-container").removeClass("hide-options");
        $(".phpfpm").addClass("is-active");
    });

    $(".nginxdomain").click(function () {
        $(".main-container").addClass("show");
        $(".set-new-chroot").removeClass("show");
        $(".set-chroot").removeClass("show");
        $(".set-phpfpm").removeClass("show");
        $(".set-nginxdomain").addClass("show");
        $(".main-container").scrollTop(0);
        $(".sidebar-link").removeClass("is-active");
        $(".main-container").addClass("hide-results");
        $(".main-container").removeClass("hide-options");
        $(".nginxdomain").addClass("is-active");
    });
    
    $(".apply").click(function () {
            $.ajax({
                type: "POST",
                url: "agent.php?f=newChroot",
                data: $("#newchroot").serialize()
            }).done(function (res) {
                $("#landingPad").html(res);
                //alert(res);
            }).fail(function (jqXHR, textStatus) {
                const msg = "impossible to create campaign! \n" + jqXHR.responseText;
                alert(msg);
                console.log(msg);
            });
            
        var source = $(this).find("source").attr("src");
        var title = $(this).find(".video-name").text();
        $(".video-p-title").text(title);
    });
    
    
});

