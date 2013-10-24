$(function() {
  $(".mark-task").click(function() {
    var checked = $(this).is(':checked');

    var data = { done: checked };
    $.ajax({
      data: data,
      url: '/tasks/' + $(this).data('team-id') + '/' + $(this).data('role-name') + '/' + $(this).data('task-id'),
      method: 'POST',
    });

    var tasksLeftSpan = $(this).closest('.task-list').find('#tasks-to-do');
    var currentCount = parseInt(tasksLeftSpan.text());
    tasksLeftSpan.text(currentCount - (checked ? 1 : -1));
		
		if checked {
			document.getElementById("task").style.setProperty("text-decoration", "line-through");
		} else {
			document.getElementById("task").style.setProperty("text-decoration", "none");
		}
  });
});
