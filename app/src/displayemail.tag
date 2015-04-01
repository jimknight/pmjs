<displayemail>
  <div class="ui message dimmable">
    <div class="ui inverted dimmer">
      <div class="ui fluid form segment">
        <div class="two fields">
          <div class="field">
            <label>First Name</label>
            <input placeholder="First Name" type="text">
          </div>
          <div class="field">
            <label>Last Name</label>
            <input placeholder="Last Name" type="text">
          </div>
        </div>
        <div class="field">
          <label>User Text</label>
          <textarea></textarea>
        </div>
        <div class="ui submit button">Submit</div>
        <div class="ui button">Cancel</div>
      </div>
    </div>
    <table style="margin-bottom:10px;width:100%;">
      <tr>
        <td style="padding-right:7px;width:30px">
          <i class="user circular icon large" id="email-avatar"></i>
        </td>
        <td style="width:200px;">
          Wayne Scarano
          <br/>sent 5 minutes ago
        </td>
        <td style="text-align:right;">
          <div class="pop ui icon button" data-content="Create a task from this email" onclick="$('.dimmable').dimmer('show');return false;">
            <i class="plus icon"></i>
          </div>
          <div class="pop ui icon button trash" data-content="Delete this email">
            <i class="trash icon"></i>
          </div>
        </td>
      </tr>
    </table>
    <div class="header">
      FW: Please perform this task
    </div>
    <div class="content">
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ultrices vel velit varius laoreet. Nunc luctus auctor vehicula. Sed semper, massa sed laoreet eleifend, metus erat porta arcu, sed ultricies enim metus vitae metus. Duis sodales, mi eu sollicitudin aliquam, nisl odio sagittis mauris, varius consequat mauris sem a lectus. Cras sit amet placerat ligula, id faucibus erat. Donec tincidunt sapien non convallis placerat. Aliquam a nisi in velit ornare tincidunt id at purus. Nam auctor lectus at ullamcorper auctor. Etiam nisl libero, consequat a leo eget, sollicitudin congue odio. Morbi a ornare nisi, in blandit ligula.
      </p>
      <p>Quisque sit amet maximus leo, quis euismod augue. Integer sed purus mattis, tempus ex ac, molestie eros. Maecenas pretium congue mauris, a posuere tortor. Vestibulum id scelerisque erat. Integer ornare, arcu ut semper tincidunt, elit ligula lacinia eros, quis pretium tellus diam quis lorem. Fusce pharetra ornare malesuada. Quisque quam elit, euismod iaculis elit non, imperdiet fermentum turpis. Duis ac iaculis nulla. Aenean pharetra est eget sem egestas, id accumsan ligula vehicula. Sed id fermentum lectus. Donec vestibulum dictum purus sit amet mattis. Aenean in gravida eros, quis dictum nulla.
      </p>
      <p>Etiam efficitur tellus et velit vehicula, a fringilla magna commodo. In molestie sapien a mi pellentesque facilisis. Morbi volutpat venenatis velit. Suspendisse id facilisis enim, sit amet tristique massa. Phasellus ac nisl nisi. Vivamus id diam pharetra, congue nisl feugiat, molestie nunc. Nam pulvinar pellentesque quam non egestas. Donec orci neque, tincidunt nec dignissim sit amet, viverra at leo. Phasellus posuere ex metus.</p>
      <h4 class="ui horizontal header divider">
        <i class="tasks icon"></i>
        Tasks
      </h4>
      <div class="ui divided items" id="emailtasks">
        <div class="ui item">
          <i class="circle thin icon red large"></i>
          <div class="actionbuttons">
            <div class="ui icon button pop checkmark" data-content="Mark task complete">
              <i class="checkmark icon"></i>
            </div>
            <div class="ui icon button pop remove" data-content="Cancel task">
              <i class="remove icon"></i>
            </div>
            <div class="ui icon button pop trash" data-content="Delete task">
              <i class="trash icon"></i>
            </div>
          </div>
          <div class="header">
            High Priority
          </div>
          <div class="meta">Created 3 days ago</div>
          <div class="content">
            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
          </div>
        </div>
        <div class="ui item">
          <i class="circle thin icon green large"></i>
          <div class="actionbuttons">
            <div class="ui icon button pop checkmark" data-content="Mark task complete">
              <i class="checkmark icon"></i>
            </div>
            <div class="ui icon button pop remove" data-content="Cancel task">
              <i class="remove icon"></i>
            </div>
            <div class="ui icon button pop trash" data-content="Delete task">
              <i class="trash icon"></i>
            </div>
          </div>
          <div class="header">Normal Priority</div>
          <div class="meta">Created 3 days ago</div>
          <div class="content">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
        </div>
        <div class="ui item">
          <i class="checkmark icon green large"></i>
          <div class="actionbuttons">
            <div class="ui icon button pop trash" data-content="Delete task">
              <i class="trash icon"></i>
            </div>
          </div>
          <div class="header">Completed</div>
          <div class="meta">Created 3 days ago</div>
          <div class="content">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
        </div>
      </div>
    </div>
  </div>
</displayemail>