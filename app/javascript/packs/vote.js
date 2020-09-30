$(document).on("click", '.increse', (e) => { postVotes(e, true) });
$(document).on("click", '.decrise', (e) => { postVotes(e, false) });

function postVotes (e, vote) {
    const button = $(e.currentTarget);
    const wrapper = button.closest('.vote');
    const messageId = button.attr('data-message-id');

    $.ajax({
        type: 'post',
        url: '/questions/:question_id/answers/' + messageId + '/vote',
        data: { up: vote }
    }).done((data) => {
        if (data.error) {
            button.attr('title', data.error);
        } else {
            wrapper.find('.score').html(data.vote_score);
            button.addClass('active');

            switchButtonColour(wrapper, button);
        }
    });
}

function switchButtonColour(wrapper, button) {
    const buttonClass = button.hasClass('increse') ? '.decrise' : '.increse';

    wrapper.find(buttonClass).removeClass('active');
}
