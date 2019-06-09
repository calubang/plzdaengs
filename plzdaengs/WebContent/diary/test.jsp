<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table  class="table table-hover">
    <thead>
      <tr>

        <th id="nameCol">ID </th>
        <th>NAME</th>
        <th >EMAIL</th>
        <th>MOBILE</th>
        <th>MESSAGE</th>
        <th>DATE & TIME</th>
        <th>STATUS</th>
        <th>REPLY</th>
      </tr>
    </thead>
    <tbody>


<?php if( is_array( $fbrecords ) && count( $fbrecords ) > 0 ) 
foreach($fbrecords as $r) { ?>
    <tr class="idrow">
        <td id="tdname"  style="display:none;" > <?php echo $r->id; ?></td>
        <td><?php echo $r->fullname; ?></td>
        <td><?php echo $r->email; ?></td>
        <td><?php echo $r->mobile; ?></td>
        <td><?php echo $r->message; ?></td>
        <td><?php echo $r->jtime; ?></td>       

<td><button type="button" class="btn btn-sm btn-success emlbtn" data-toggle="modal" data-target="#myModal"> Reply to <?php $fname=explode(" ",$r->fullname); echo $fname[0]; ?></button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Reply to <?php $fname=explode(" ",$r->fullname); echo $fname[0]; ?> </h4>
        </div>
        <div class="modal-body">
        <?php echo form_open('user_authentication/new_user_registration',array('id'=>'register-form')); ?>
           <label>Recipient :</label>
          <input type="text" id="recepient" value= "<?php  echo $r->email;  ?>" style="cursor:not-allowed" disabled ></input>
          <br> </br>
          <label>Subject :</label>
          <input type="text" id="recepient" value= "Re: <?php $msg=$r->message; echo substr($msg,0,20); echo "......"; ?>"  ></input>
          <br> </br>
          <label>Message :</label>
          <textarea value="Your Message" style="margin: 0px; width: 564px; height: 131px;"></textarea>
        <br> </br>
          <?php echo form_submit('submit', 'Send Mail');
          echo form_close(); ?>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>

    </div>
  </div>

        </td>