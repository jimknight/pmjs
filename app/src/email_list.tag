<email_list>
  <div class='ui divided items' id="emaillist">
    <email_selector each={this.globals.emails} data="{ this }"></email_selector>
  </div>
  <script>
    this.globals = this.parent.globals;
  </script>
</email_list>

<email_selector>
  <div class={this.parent.parent.parent.globals.email_id == id ? 'item active' : 'item'}>
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
    this.globals = opts.data.parent.globals;
    bodyText(longString) {
      return _.trunc(longString, {
        'length': 50,
        'separator': ' '
      });
    };
  </script>
</email_selector>