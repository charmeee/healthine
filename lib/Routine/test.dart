// {
// "items": [],
// "meta": {
// "totalItems": 0,
// "itemCount": 0,
// "itemsPerPage": 20,
// "totalPages": 0,
// "currentPage": 1
// }
// }
//전체 내루틴을 들고있고 그걸구독함. 오늘의뤁
// [알림창]
// 해당 요일에는 이미 루틴이 존재합니다. 지금 이 루틴으로 변경할까요?
// [예] [아니요]

//
//
List<Map<String, dynamic>> myRoutineListEx = [
  {
    "id": "string1",
    "title": "string1",
    "days": [1, 1, 0, 0, 1, 0, 1],
    "type": ["유산소", "팔", "가슴"]
  },
  {
    "id": "string4",
    "title": "string4",
    "days": [0, 0, 1, 1, 0, 1, 0],
    "type": ["유산소", "팔", "가슴"]
  },
];

Map<String, dynamic> myRoutineEx = {
  "id": "string1",
  "title": "string1",
  "day": [1, 1, 0, 0, 1, 0, 1],
  "type": ["유산소", "팔", "가슴"],
  "routineManuals": [
    {
      "manualId": "4f138328-975e-4d17-85a3-7cb389bd018d",
      "routineManualId": "string2",
      "manualTitle": "string2",
      "targetNumber": 0,
      "setNumber": 0,
      "weight": 0,
      "speed": 0,
      "playMinute": 0,
      "order": 0,
      "type": "back"
    },
    {
      "manualId": "4f138328-975e-4d17-85a3-7cb389bd018d",
      "routineManualId": "string3",
      "manualTitle": "string3",
      "targetNumber": 0,
      "setNumber": 0,
      "weight": 0,
      "speed": 0,
      "playMinute": 0,
      "order": 0,
      "type": "back"
    }
  ]
};

List<Map<String, dynamic>> referenceRoutineList = [
  {
    "id": "string",
    "title": "string",
    "description": "string",
    "author": "string", // 원본 생성자 회원의 닉네임
    "types": ["팔", "가슴"], // ['chest', 팔, 가슴]
    "likesCount": int,
  }
];

Map<String, dynamic> referenceRoutineEx = {
  "id": "string",
  "title": "string",
  "description": "string",
  "author": "string", // 원본 생성자 회원의 닉네임
  "types": ["팔", "가슴"], // ['chest', 팔, 가슴]
  "likesCount": int,
  "routineManuals": [
    {
      "manualId": "4f138328-975e-4d17-85a3-7cb389bd018d",
      "routineManualId": "string5",
      "manualTitle": "string",
      "targetNumber": 0,
      "setNumber": 0,
      "weight": 0,
      "speed": 0,
      "playMinute": 0,
      "order": 0,
      "type": "back"
    },
    {
      "manualId": "4f138328-975e-4d17-85a3-7cb389bd018d",
      "routineManualId": "string6",
      "targetNumber": 0,
      "setNumber": 0,
      "weight": 0,
      "speed": 0,
      "playMinute": 0,
      "order": 0,
      "type": "back"
    }
  ]
};

List<Map<String, dynamic>> recordTestEx = [
  {
    "id": "string1",
    "routineTitle": "string",
    "manualId": "4f138328-975e-4d17-85a3-7cb389bd018d",
    "targetNumber": 0,
    "setNumber": 0,
    "weight": 0,
    "speed": 0,
    "playMinute": 0,
    "startedAt": "2022-10-24T10:57:33.892Z",
    "endedAt": "2022-10-24T10:57:33.892Z",
    "createdAt": "2022-10-26T13:43:25.658Z",
  }
];

//post용 json
// {
// "routineId": "string",
// "manualId": "string",
// "startedAt": "2022-10-26T13:48:04.203Z",
// "endedAt": "2022-10-26T13:48:04.203Z",
// "targetNumber": 0,
// "setNumber": 0,
// "weight": 0,
// "speed": 0,
// "playMinute": 0
// }
