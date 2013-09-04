$(function() {
  $(".mark-task").click(function() {
    var data = { done: $(this).is(':checked') };
    $.ajax({
      data: data,
      url: '/tasks/' + $(this).data('team-id') + '/' + $(this).data('role-name') + '/' + $(this).data('task-id'),
      method: 'POST',
    });
  });
});
