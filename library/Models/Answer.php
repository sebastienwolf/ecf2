<?php

namespace Models;



class Answer extends Model
{

    protected $table = "answer";

    // ===================================================================================================
    // ===============================        solution   ===================================
    // ===================================================================================================

    public function solution($id)
    {
        $query = "SELECT answer_has_solution.*, answer.label, question.label AS question, question.coefficient  FROM $this->table 
        INNER JOIN  answer_has_solution ON answer.id = answer_has_solution.answer_id
        INNER JOIN question ON question.id = answer.question_id
        WHERE answer.id = ?";

        $sql = $this->pdo->prepare($query);
        $sql->execute([$id]);
        $solution = $sql->fetchAll();

        return $solution;
    }


    // ===================================================================================================
    // ===============================        winner   ===================================
    // ===================================================================================================

    public function winner($id)
    {
        $query = "SELECT * FROM `solution` WHERE id = ?";

        $sql = $this->pdo->prepare($query);
        $sql->execute([$id]);
        $winner = $sql->fetchAll();

        return $winner[0];
    }
}
