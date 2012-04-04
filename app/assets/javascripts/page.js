Permissions = {

    init:function(){
	$('select#editor_id').change(this.addEditor.bind(this));
	$('img.remove-sub').click(this.removeSubscription.bind(this));
    },


    addEditor:function(event) {
	var select = $(event.target),
	user_id = select.val();
	if (user_id) {
	    var page_id = select.data()['page_id'];
	    this.addSubscription(page_id, user_id, 'write');
	}
    },
    
    addSubscription:function(page_id, user_id, rights){
	$.post('/permissions', {user_id:user_id, page_id:page_id, rights: rights}, this.renderPageInfo.bind(this));
    },
    
    removeSubscription:function(event){
	var id = $(event.target).data()['id'];
	$.ajax({type:'DELETE', url:'/permissions/' + id, success:this.renderPageInfo.bind(this)});
    },

    renderPageInfo:function(data){
	$('div#page-info').html(data);
	this.init();
    }
    
};

$(function(){
    Permissions.init()
});