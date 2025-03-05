import 'package:basic_layout/data/models/dto/todo_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://67c819070acf98d07084d306.mockapi.io")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/todos/Todo")
  Future<List<TodoDto>> getTodo();

  @POST("/todos/Todo")
  Future<TodoDto> addTodo(@Body() TodoDto todo);

  @PUT("/todos/Todo/{id}")
  Future<dynamic> hasDoneTodo(
    @Path("id") String id,
    @Body() Map<String, bool> completed,
  );

  @DELETE("/todos/Todo/{id}")
  Future<void> deleteTodo(@Path("id") String id);
}
