Permissions = {

    init:function(){
	$('select#editor_id').change(this.addEditor.bind(this));
	$('div#page-info img.remove').click(this.removeSubscription.bind(this));
    },


    addEditor:function(event) {
	var select = $(event.target),
	entity_id = select.val();
	if (entity_id) {
	    var page_id = select.data()['page_id'];
	    this.addSubscription(page_id, entity_id, 'write');
	}
    },
    
    addSubscription:function(page_id, entity_id, rights){
	$.post('/permissions', {entity_id:entity_id, page_id:page_id, rights: rights}, this.renderPageInfo.bind(this));
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

Form = {
    init: function(){
//        $('input#page_title').keyup(this.validateTitle.bind(this));
    },

    validateTitle: function(event){
        var input = $(event.target);
        input.val(input.val().replace(/\W/,''));
    }
};

$(function(){
    Permissions.init();
    Form.init();
});