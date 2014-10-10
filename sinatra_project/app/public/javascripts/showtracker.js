$(function() {
    var $container = $("#wrap > .container");
    var $cards     = $(".card");
    var $card      = $cards.first();
    var $document  = $(document);

    // Show additional info for shows with long titles
    $cards.mouseenter(function() {
        var $this = $cards.eq($(this).index());

        if ($this.has(".long-title").length) {
            $this.find("h1").fadeOut(100);
            $this.find("dl").delay(100).fadeIn(100);
        }
    }).mouseleave(function() {
        var $this = $cards.eq($(this).index());

        if ($this.has(".long-title").length) {
            $this.find("dl").fadeOut(100)
            $this.find("h1").delay(100).fadeIn(100);
        }
    });

    $(".confirm").on("click", function(e) {
        e.preventDefault();
        var $this = $(this);
        var message = $this.data('confirm');

        BootstrapDialog.confirm(message, function(result){
            if(result) {
                window.location.href = e.currentTarget.href;
            }
        });
    });
})
