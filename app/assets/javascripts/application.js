// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks

//= require jquery/jquery.min
//= require bootstrap/bootstrap.min
//= require sweetalert2
//= require rails-sweetalert2-confirm

//=! require_tree .

/* ajax绑定方法 */
function ajaxBind(dom, successMsg, failMsg, successFallback, failFallBack) {
    $(dom).on('ajax:success', function(e, data, status, xhr) {
        let rdata = e.detail[0];
        console.log(rdata);
        if (rdata.success)
            ajaxSuccess(rdata, successMsg, successFallback);
        else
            ajaxFailure(rdata, failMsg, failFallBack);
    }).on('ajax:error', function(e, xhr, status, error) {
        let rdata = e.detail[0];
        console.log(rdata);
        ajaxFailure(rdata, failMsg, failFallBack);
    });
}

function ajaxSuccess(rdata, successMsg, successFallback) {
    Swal.fire({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        type: 'success',
        title: successMsg || rdata.msg
    })
    if (typeof successFallback == 'function')
        successFallback(rdata);
}

function ajaxFailure(rdata, failMsg, failFallBack) {
    Swal.fire({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        type: 'error',
        title: failMsg || rdata.msg
    })
    if (typeof failFallBack == 'function')
        failFallBack(rdata);
}