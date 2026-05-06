
/* 
   NGUYÊN NHÂN VI PHẠM QUY TẮC TOÁN HỌC:
   
   1. Tính mập mờ (Ambiguity): 
      Khi ta GROUP BY theo [hotel_id], SQL sẽ gộp nhiều dòng dữ liệu của cùng một 
      khách sạn thành 1 dòng duy nhất. Trong khi đó, một khách sạn có thể có 
      nhiều loại phòng với các [room_name] khác nhau (Phòng Đơn, Phòng Đôi, Suite...).
   
   2. Xung đột dữ liệu: 
      Cột [price_per_night] đã có hàm MIN() để xác định giá trị nhỏ nhất (rõ ràng). 
      Tuy nhiên, cột [room_name] lại không có hàm định hướng. SQL sẽ không biết 
      phải chọn "tên phòng" nào để hiển thị đại diện cho nhóm đó. 
   
   3. Chế độ ONLY_FULL_GROUP_BY: 
      Đây là tiêu chuẩn của SQL hiện đại. Nó yêu cầu tất cả các cột xuất hiện trong 
      mệnh đề SELECT (mà không nằm trong hàm tổng hợp như MIN, MAX, SUM...) 
      thì BẮT BUỘC phải xuất hiện trong mệnh đề GROUP BY.
*/

/* 
   GIẢI PHÁP: 
   Để lấy đúng ID khách sạn và Giá thấp nhất mà không vi phạm quy tắc, 
   ta loại bỏ cột gây mập mờ là [room_name] ra khỏi câu lệnh SELECT.
*/

-- Câu lệnh SQL chuẩn mực:
SELECT 
    hotel_id, 
    MIN(price_per_night) AS min_price
FROM 
    Rooms
GROUP BY 
    hotel_id;

/* 
   GHI CHÚ: 
   Nếu sau này bạn vẫn muốn lấy ra đúng cái "Tên phòng" có giá rẻ nhất đó, 
   ta không thể dùng GROUP BY đơn giản mà phải dùng Subquery hoặc Window Function:
   
   SELECT hotel_id, room_name, price_per_night
   FROM Rooms
   WHERE (hotel_id, price_per_night) IN (
       SELECT hotel_id, MIN(price_per_night)
       FROM Rooms
       GROUP BY hotel_id
   );
*/
