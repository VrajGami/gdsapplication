
class User{
  final int Id;
    final String Name;
  final String Password;
  final String Role;
  final bool Q1;
  final bool Q2;
  final bool Q3;
  final bool Q4;
  final bool Q5;
  final bool Q6;
  final bool Q7;
  final bool Q8;
  final bool Q9;
  final bool Q10;
  final bool Q11;
  final bool Q12;
  final bool Q13;
  final bool Q14;
  final bool Q15;
  final int Score;
  const User({required this.Id, required this.Name,required this.Password, required this.Role, 
  required this.Q1,required this.Q2, required this.Q3,required this.Q4, required this.Q5,
  required this.Q6,required this.Q7,required this.Q8,required this.Q9,required this.Q10,
  required this.Q11,required this.Q12,required this.Q13,required this.Q14,required this.Q15,required this.Score});

  factory User.fromJson(Map<String,dynamic> json) => User(
    Id: json["id"], Name: json["name"], Password: json["password"], Role: json["role"], Q1: json["q1"], 
    Q2: json["q2"], Q3: json["q3"], Q4: json["q4"], Q5: json["q5"], Q6: json["q6"], Q7: json["q7"], 
    Q8: json["q8"], Q9: json["q9"], Q10: json["q10"], Q11: json["q11"], Q12: json["q12"], Q13: json["q13"], 
    Q14: json["q14"], Q15: json["q15"], Score: json["score"]);

 List<String> get answers => [
        Q1 ? "Yes" : "No",
        Q2 ? "Yes" : "No",
        Q3 ? "Yes" : "No",
        Q4 ? "Yes" : "No",
        Q5 ? "Yes" : "No",
        Q6 ? "Yes" : "No",
        Q7 ? "Yes" : "No",
        Q8 ? "Yes" : "No",
        Q9 ? "Yes" : "No",
        Q10 ? "Yes" : "No",
        Q11 ? "Yes" : "No",
        Q12 ? "Yes" : "No",
        Q13 ? "Yes" : "No",
        Q14 ? "Yes" : "No",
        Q15 ? "Yes" : "No",
      ];

  Map<String, dynamic> toJson() => {
    "id" : Id, "name" : Name, "password" : Password, "role" : Role, "q1" : Q1,  "q2" : Q2, "q3" : Q3, "q4" : Q4, "q5" : Q5
    , "q6" : Q6, "q7" : Q7, "q8" : Q8, "q9" : Q9, "q10" : Q10, "q11" : Q11, "q12" : Q12, "q13" : Q13,
     "q14" : Q14, "q15" : Q15, "score" : Score
  };
}