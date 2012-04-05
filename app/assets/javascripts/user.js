User = {

    init:function(){
	$('select#team_id').change(this.addUserToTeam.bind(this));
	$('div#user-teams img.remove').click(this.removeFromTeam.bind(this));
    },


    addUserToTeam:function(event) {
	var select = $(event.target),
	team_id = select.val();
	if (team_id) {
	    var user_id = select.data()['user_id'];
	    $.post('/teams/'+team_id+'/add', {user_id:user_id}, this.renderUserTeams.bind(this));
	}
    },
        
    removeFromTeam:function(event){
        var data = $(event.target).data(),
	team_id = data['team_id'],
	user_id = data['user_id'];
	$.ajax({type:'DELETE', url:'/teams/' + team_id + '/remove', data:{user_id:user_id}, success:this.renderUserTeams.bind(this)});
    },

    renderUserTeams:function(data){
	$('div#user-teams').html(data);
	this.init();
    }
    
};

$(function(){
    User.init()
});