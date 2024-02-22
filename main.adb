with Ada.Text_IO;
use Ada.Text_IO;

procedure Main is
   is_break: Boolean := false;
   threads_num : Integer := 5;
   pragma Atomic(is_break);
   thread_id : Integer := 0;
   allowed_time_seconds : Duration := 55.0;
   allowed_time_seconds_wait : Duration := 3.0;

   task type break_thread;
   task type main_thread;

   task body break_thread is
   begin
      delay allowed_time_seconds;
      is_break := true;
   end break_thread;

   task body main_thread is
      sequence_step : Long_Integer := 2;
      sequence_sum : Long_Integer := 0;
      count_element : Long_Integer := 0;
      local_thread_id : Integer := 0;
   begin
      local_thread_id := thread_id;
      thread_id := thread_id + 1;

      loop
         exit when is_break;
         sequence_sum := sequence_sum + sequence_step;
         count_element := count_element + 1;
      end loop;
      Put_Line("Thread " & local_thread_id'Img & " Sum: " & sequence_sum'Img & " Number of elements: " & count_element'Img);
   end main_thread;

   b1: break_thread;
   threads : array (1..threads_num) of main_thread;

begin
   delay (allowed_time_seconds + allowed_time_seconds_wait);
end Main;