<email_selector>
  <div class='item'>
    <h2>{email_id}</h2>
    <div class='ui grid'>
      <div class='two wide column'>
        <i class='circular user icon large'></i>
      </div>
      <div class='fourteen wide column'>
        <div class='content'>
          <a class='header' href={'#projects/23/emails/' + id}>{subject}</a>
          <div class='meta'>
            <span class='cinema'>from {sent_from} 5 minutes ago</span>
          </div>
          <div class='description'>
            <p>{bodyText(body_plain)}</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    console.log(opts);
    // this.email_id = opts.email_id;
    bodyText(longString) {
      return _.trunc(longString, {
        'length': 50,
        'separator': ' '
      });
    };
  </script>

</email_selector>

<email_list>
  <div class='ui divided items'>
    <email_selector each={opts.emails}></email_selector>
  </div>
  <script>
    // console.log(opts.email_id);
  </script>
</email_list>