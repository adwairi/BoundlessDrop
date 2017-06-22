/**
 * Created by ali on 6/22/17.
 */

$(document).ready(function () {
    init_data_toggle();
});

function init_data_toggle() {
    $('[data-toggle="ajaxModal"]').unbind().click(function (event) {
        ajaxModal(this, event);
    });
    $('[data-toggle="ajaxRequest"]').unbind().click(function (event) {
        ajaxRequest(this, event);
    });
    $('[data-toggle="ajaxSubmit"]').unbind().submit(function(event){
        ajaxSubmit(this, event);
    });
    $('[data-toggle="confirmAction"]').unbind().click(function (event) {
        confirmAction(this, event);
    });
    $('[data-toggle="deleteAction"]').unbind().click(function (event) {
        deleteAction(this, event);
    });
    $('[data-toggle="deleteRedirectAction"]').unbind().click(function (event) {
        deleteRedirectAction(this, event);
    });
    $('[data-toggle="ajaxDelete"]').unbind().submit(function(event){
        ajaxDelete(this, event);
    });
    $('[data-loading-text]').on('click', function (event) {
        $(this).button('loading');
    });
}

function ajaxRequest(element, event) {
    event.preventDefault();

    var data = $(element).data();

    if(data.scroll !== false) {
        data.scroll = true;
    }

    $('#'+$(element).attr('data-target')).html('<div class="progress progress-striped active no-margin" >' +
        '<div class="progress-bar" style="width: 100%;"><i class="fa fa-spinner fa-spin"></i> Loading</div>' +
        '</div>');

    $.ajax({
        type: "POST",
        url: $(element).attr('href')
    }).done(function (msg) {
        var $_target = $('#'+$(element).attr('data-target'));

        $_target.html(msg);
        init_data_toggle();

        if(data.scroll) {
            $('html, body').stop().animate({
                'scrollTop': $_target.offset().top
            }, 500, 'swing');
        }

        if ($(element).attr('data-add-class') === "true") {
            $($(element).attr('data-ref')).removeClass('active');
            $(element).parent().addClass('active');
        }
    }).fail(function () {
        window.location.reload();
    });
}

function ajaxModal(element, event) {
    event.preventDefault();

    if (typeof(tinymce) !== "undefined") {
        tinymce.remove("textarea");
    }

    $('#ajaxModal').remove();

    $('body').append('<div class="modal fade" id="ajaxModal" tabindex="-1" data-backdrop="static" aria-hidden="true">' +
        ' <div id="ajaxModalDialog">' +
        '  <div class="modal-dialog">' +
        '   <div class="modal-content">' +
        '    <div class="modal-body">' +
        '     <div class="progress">' +
        '      <div class="progress-bar progress-bar-striped active" style="width: 100%; height: 21px;"><i class="fa fa-spinner fa-spin"></i> Loading</div>' +
        '     </div>' +
        '    </div>' +
        '   </div>' +
        '  </div>' +
        ' </div>' +
        '</div>');

    $('#ajaxModalDialog').load($(element).attr('href'), function() {
        init_data_toggle();
    });

    $('#ajaxModal').modal('show');

    $('#ajaxModal').on('shown.bs.modal', function () {
        resetModalBackdropHeight();
        afterModal();
        $('#ajaxModalDialog').bind('DOMNodeInserted DOMNodeRemoved', resetModalBackdropHeight);
    });

    var confirm_flag = false;

    $('#ajaxModal').on('hide.bs.modal', function () {

        var $_modal = $(this).find('.modal-dialog').first();

        var flag = $_modal.attr('confirm');
        var message = $_modal.attr('message') ? $_modal.attr('message') : "Are you sure?" ;

        if (typeof flag !== typeof undefined && flag !== false && confirm_flag === false) {

            bootbox.confirm({
                message: message,
                backdrop: false,
                callback: function (result) {
                    if (result) {
                        confirm_flag = true;
                        $('#ajaxModal').modal('hide');
                    }
                },
                className: "bootbox-sm"
            });

            $('.bootbox.modal').on('hidden.bs.modal', function () {
                if ($('#ajaxModalDialog').length) {
                    $('body').addClass('modal-open');
                }
            });

            return false;
        }
    });

    $('#ajaxModal').on('hidden.bs.modal', function () {
        if (typeof(tinymce) !== "undefined") {
            tinymce.remove("textarea");
        }
        $('#ajaxModal').remove();
    });
}

function afterModal()
{
    return true;
}

function resetModalBackdropHeight() {
    var $_modal     = $('.modal-dialog');
    var $_backdrop  = $('.modal-backdrop');
    var el_height  = $_modal.innerHeight();

    $_backdrop.css({
        height: el_height + 60,
        minHeight: '100%'
    });
}

function deleteRedirectAction(element, event) {
    event.preventDefault();

    var message = $(element).attr('message') ? $(element).attr('message') : "Are you sure?" ;

    bootbox.confirm({
        message: message,
        callback: function (result) {
            if (result) {
                var $href = $(element).attr('href');

                $.ajax({
                    type: "GET",
                    url: $href,
                    dataType: "json"
                }).done(function (msg) {
                    window.location.replace(msg.path);
                    //window.location.reload(msg.path);
                }).fail(function (msg) {//alert(msg.path);
                    window.location.replace(msg.path);
                    // window.location.reload(msg);

                });
            }
        },
        className: "bootbox-sm"
    });

    $('.bootbox.modal').on('hidden.bs.modal', function () {
        if ($('#ajaxModalDialog').length) {
            $('body').addClass('modal-open');
        }
    });

}

function deleteAction(element, event) {
    event.preventDefault();

    var message = $(element).attr('message') ? $(element).attr('message') : "Are you sure?" ;

    bootbox.confirm({
        message: message,
        callback: function (result) {
            if (result) {
                var $href = $(element).attr('href');

                $.ajax({
                    type: "GET",
                    url: $href,
                    dataType: "json"
                }).done(function (msg) {
                    init_data_toggle();
                    after_delete_action(element, msg);
                }).fail(function () {
                    window.location.reload();
                });
            }
        },
        className: "bootbox-sm"
    });

    $('.bootbox.modal').on('hidden.bs.modal', function () {
        if ($('#ajaxModalDialog').length) {
            $('body').addClass('modal-open');
        }
    });

}

function after_delete_action(element, msg) {
    window.location.reload();
}

function ajaxDelete(element, event) {
    event.preventDefault();

    // $('#'+$(element).attr('data-target')).html('<div class="progress progress-striped active"><div class="progress-bar" style="width: 100%;"></div></div>');
    var message = $(element).attr('message') ? $(element).attr('message') : "Are you sure?" ;

    bootbox.confirm({
        message: message,
        callback: function (result) {
            if (result) {
                $.ajax({
                    type: "POST",
                    url: $(element).attr('action'),
                    data: $(element).serialize()
                }).done(function () {
                    // init_data_toggle();
                    location.reload();
                }).fail(function (msg) {
                    window.location.reload();
                });
            }
        },
        className: "bootbox-sm"
    });

}

function confirmAction(element, event) {
    event.preventDefault();

    var message = $(element).attr('message') ? $(element).attr('message') : "Are you sure?" ;

    bootbox.confirm({
        message: message,
        callback: function (result) {
            if (result) {
                var $href = $(element).attr('href');

                window.location = $href;
            }
        },
        className: "bootbox-sm"
    });

    $('.bootbox.modal').on('hidden.bs.modal', function () {
        if ($('#ajaxModalDialog').length) {
            $('body').addClass('modal-open');
        }
    });

}

function ajaxSubmit(element, event) {
    event.preventDefault();

    $('#'+$(element).attr('data-target')).html('<div class="progress progress-striped active"><div class="progress-bar" style="width: 100%;"></div></div>');

    $.ajax({
        type: "POST",
        url: $(element).attr('action'),
        data: $(element).serialize()
    }).done(function (msg) {
        var target = $('#'+$(element).attr('data-target'));
        target.html(msg);
        init_data_toggle();
        $('html, body').stop().animate({
            'scrollTop': target.offset().top
        }, 500, 'swing');
    }).fail(function (msg) {
        window.location.reload();
    });
}

function do_post_submit(url, form_id, div_id) {

    $('#' + div_id).html(
        '<div class="progress">' +
        '   <div class="progress-bar progress-bar-striped active" style="width: 100%; height: 21px;"><i class="fa fa-spinner fa-spin"></i> Loading</div>' +
        '</div>');

    $.ajax({
        type: "POST",
        url: url,
        data: $('#' + form_id).serialize(),
        success: function (result) {
            if (result === '1') {
                window.location.reload();
            } else {
                $('#' + div_id).html(result);
            }
        }
    });
}