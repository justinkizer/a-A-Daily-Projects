const APIUtil = {
  followUser: id => (
    $.ajax({
      type: 'POST',
      dataType: "json",
      url: `/users/${id}/follow`,
    })
  ),

  unfollowUser: id => (
    $.ajax({
      type: 'DELETE',
      dataType: "json",
      url: `/users/${id}/follow`,
    })
  ),

  searchUsers: query => (
    $.ajax({
      type: 'GET',
      dataType: "json",
      url: "/users/search",
      data: { query }
    })
  ),

  createTweet: data => (
    $.ajax({
      type: 'POST',
      dataType: "json",
      url: "/tweets",
      data: { data }
    })
  )

};

module.exports = APIUtil;
