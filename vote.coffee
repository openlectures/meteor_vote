
Lectures = new Meteor.Collection("lectures")

if Meteor.is_client
  Template.list.lectures = -> Lectures.find()

  Template.list.events =
    'click #upvote': (event) ->
      event.preventDefault()
      id = $(event.currentTarget).parent().attr('data-lecture-id')
      score = Lectures.findOne(_id: id).score + 1
      Lectures.update(id, $set: {score:score})
      console.log($(event.currentTarget))
      $(event.currentTarget).attr("disabled", "disabled")

  Template.form.events =
          'submit #new_entry': (event) ->
                  event.preventDefault()
                  Lectures.insert(subject: $('#new_lecture_subject').val(), title: $('#new_lecture_title').val(), score: "0")
                  $('#new_lecture_subject').val('')
                  $('#new_lecture_title').val('')

if Meteor.isServer
  Accounts.loginServiceConfiguration.remove service: "facebook"

  Accounts.loginServiceConfiguration.insert
    service: "facebook"
    appId: "353891734712749"
    secret: "3deefaa0fa21c5855c52314ed59b2a38"
