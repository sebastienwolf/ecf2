<?php

namespace Models;



class Question extends Model
{

  protected $table = "question";

  // ===================================================================================================
  // ===============================        takeTheQuestionsAndAnswer    ===========================================
  // ===================================================================================================

  /**
   * 
   * permet d'appeler les questions et les réponses 
   * 
   */
  public function takeTheQuestionsAndAnswer($object, $category)
  {
    $query = "SELECT question.label AS question, answer.id, answer.label, type.label as type FROM $this->table
          LEFT JOIN answer ON answer.question_id = question.id
          LEFT JOIN type ON question.type_id = type.id
          WHERE question.category_id = ?
          ORDER BY question.position, answer.position ASC";

    $sql = $this->pdo->prepare($query);
    $sql->execute([$category]);
    $answer = $sql->fetchAll();
    $object->all = $answer;
    return $object;
  }

  // ===================================================================================================
  // ===============================        selectQuiz    ===========================================
  // ===================================================================================================
  public function selectQuiz($category)
  {

    $query = "SELECT * FROM category
          WHERE name = ?";

    $sql = $this->pdo->prepare($query);
    $sql->execute([$category]);
    $answer = $sql->fetch();

    return $answer;
  }
}
