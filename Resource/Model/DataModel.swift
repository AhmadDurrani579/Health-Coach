//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper


class UserResponse: Mappable {
    
    var success                           :       Bool?
    var message                           :       String?
    var msg                               :       String?

    var status                            :       Int?
    var data                              :       UserObjectInfo?
    var allInterest                       :       [AllInterestObject]?
    var addInterest                       :       AllInterestObject?
    var getUserDetail                     :       UserDetail?
    var addFoodItem                       :       FoodToday?
    var exerciseObject                    :       [ExerciseObjects]?
    var waterObject                       :       WaterToday?
    var kitechenItemList                  :       [KitchenObject]?
    var foodItemList                      :       [FoodToday]?
    var execiseObj                        :       [ExerciseObjects]?
    var appointMentList                   :       [AppointmentList]?
    var packageList                       :       PackageOfCoach?
    var uploadPicture                     :       UploadPic?
    var chartData                         :       ExerciseObject?
    var listOfNotification                :       [NotificationList]?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        status          <- map["status"]
        message         <- map["message"]
        msg              <- map["msg"]
        success            <- map["success"]
        data            <- map["user"]
        allInterest     <- map["data"]
        addInterest     <- map["data"]
        getUserDetail     <- map["data"]
        addFoodItem       <- map["data"]
        exerciseObject       <- map["data"]
        waterObject       <- map["data"]
        kitechenItemList  <- map["data"]
        foodItemList       <- map["data"]
        execiseObj       <- map["data"]
        appointMentList <- map["data"]
        packageList <- map["data"]
        uploadPicture <- map["data"]
        chartData  <- map["chart_data"]
        listOfNotification <- map["data"]
    }
}


class UserObjectInfo : Mappable {
    
    var id                                   :       String?
    var login_token                          :       String?
    var email                                :       String?
    var first_name                           :       String?
    var last_name                            :       String?
    var goal                                 :      String?
    var date_of_birth                        :      String?
    var interests                            :      String?
    var preferred_style                      :      String?
    var profile_pic                          :      String?
//    var target_weight                        :      String?
//    var target_description                        :      String?


    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        login_token <- map["login_token"]
        email <- map["email"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        goal <- map["goal"]
        date_of_birth <- map["date_of_birth"]
        interests <- map["interests"]
        preferred_style <- map["preferred_style"]
        profile_pic <- map["profile_pic"]

//        target_weight <- map["target_weight"]
//        target_description <- map["target_description"]


    }
}

class ProfilePicUpdate: Mappable {
    
    var success                           :       Bool?
    var message                           :       String?
    var msg                               :       String?
    var status                            :       String?
    var data                              :       ProfilePicUpdateModel?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        status          <- map["status"]
        message         <- map["message"]
        msg              <- map["msg"]
        success            <- map["success"]
        data            <- map["data"]
    }
}


class ProfilePicUpdateModel: Mappable {
    
    var image                                   :       String?


    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
    }
}


class NotificationList : Mappable {
    
    var from_fname                                   :       String?
    var from_lname                          :       String?
    var from_profile_pic                                :       String?
    var titleOfNotification                           :       String?
    var message                            :       String?
    var date                                 :      String?


    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        from_fname <- map["from_fname"]
        from_lname <- map["from_lname"]
        from_profile_pic <- map["from_profile_pic"]
        titleOfNotification <- map["title"]
        message <- map["message"]
        date <- map["date"]

    }
}


class AllInterestObject : Mappable {
    
    var id                                        :       String?
    var name                                      :       String?
    var icon                                      :       String?
    var date                                      :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        date <- map["date"]
    }
}


class UserGroupObject : Mappable {
    
    var group_id                                         :       String?
    var group_title                                      :       String?
    var joined                                           :       Int?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        group_id <- map["group_id"]
        group_title <- map["group_title"]
        joined <- map["joined"]
    }
}

class UserGroupLikeObject : Mappable {
    
    var group_id                                        :       String?
    var group_title                                      :       String?
    var joined                                      :       Int?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        group_id <- map["group_id"]
        group_title <- map["group_title"]
        joined <- map["joined"]
    }
}

class GroupPosts : Mappable {
    
    var id                                       :       String?
    var text                                     :       String?
    var image                                    :       String?
    var created_at                               :       String?
    var comment                                  :       [AllCommentOnPost]?
    var post_likes                                    :       Int?
    var is_user_liked                               :       Bool?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
        image <- map["image"]
        created_at <- map["created_at"]
        comment   <- map["all_comments"]
        post_likes   <- map["post_likes"]
        is_user_liked   <- map["is_user_liked"]

    }
}

class AllCommentOnPost : Mappable {
    
    var id                                        :       String?
    var comment                                      :       String?
    var username                                      :       String?
    var created_at                                      :       String?

    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        comment <- map["comment"]
        username <- map["username"]
        created_at <- map["created_at"]

    }
}

class PodCostModel : Mappable {
    
    var id                                             :       String?
    var title                                          :       String?
    var file                                           :       String?
    var created_at                                     :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        file <- map["file"]
        created_at <- map["created_at"]
        
    }
}

class UserDetail : Mappable {
    
    var foodToday                                                    :       [FoodToday]?
    var userHealth                                                   :       [UserHealth]?
    var waterToday                                                   :       WaterToday?
    var userDetailObject                                             :       UserDetailObject?
    var exerciseObjectss                                             :       [ExerciseObjects]?
    var kitchenObject                                                :       [KitchenObject]?
    var sleep                                                        :       SleepObject?
    var water                                                        :       WaterObject?
    var exerciseReport                                               :       ExerciseObject?
    var trialVersion                                                 :       [TrialVersion]?
    var subscription                                                 :       Subscripe?
    var appointments                                                 :       [Appointment]?
    var nextAppointMent                                              :       [Appointment]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        foodToday <- map["food_today"]
        userHealth <- map["user_health"]
        waterToday <- map["water_today"]
        userDetailObject <- map["user_details"]
        exerciseObjectss <- map["exercise"]
        kitchenObject <- map["kitchen"]
        sleep <- map["sleep"]
        water <- map["water"]
        exerciseReport <- map["exercise_report"]
        subscription <- map["subscriptions"]
        trialVersion <- map["trial"]
        appointments <- map["appointments"]
        nextAppointMent <- map["next_appointment"]
    }
}

class Food: Mappable {
    
    var success                           :       Bool?
    var message                           :       String?
    var msg                               :       String?
    var status                            :       Int?
    var addFoodItem                       :       FoodToday?
    var kitchenItem                       :       KitchenObject?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        status          <- map["status"]
        message         <- map["message"]
        msg              <- map["msg"]
        success            <- map["success"]
        addFoodItem       <- map["data"]
        kitchenItem       <- map["data"]
    }
}


class FoodToday : Mappable {
    
    var id                                                 :       String?
    var food_type                                          :       String?
    var image                                              :       String?
    var date_selected                                      :       String?
    var idOfItem                                           :       Int?
    
    required init?(map: Map){

    }
    func mapping(map: Map) {
        id <- map["id"]
        food_type <- map["food_type"]
        image <- map["image"]
        date_selected <- map["date_selected"]
        idOfItem <- map["id"]

        
    }
}

class Subscripe : Mappable {
    
    var is_subscribed                                                 :       Bool?
    var trial                                                         :       Bool?
    var duration                                                      :       String?
    var price                                                         :       String?
    var is_paid                                                       :       String?
    var date                                                          :       String?
    var is_expired                                                    :       Bool?
    var expiryDate                                                          :       String?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        is_subscribed <- map["is_subscribed"]
        trial <- map["trial"]
        duration <- map["duration"]
        price <- map["price"]
        is_paid <- map["is_paid"]
        date <- map["date"]
        is_expired <- map["is_expired"]
        expiryDate <- map["expiry_date"]
        
    }
}

class Appointment : Mappable {
    
    var id                                                 :       String?
    var date                                                         :       String?
    var day                                                      :       String?
    var from                                                         :       String?
    var to                                                       :       String?
    var service_name                                                          :       String?
    var service_id                                                    :       String?
    var note                                                :    String?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        date <- map["date"]
        day <- map["day"]
        from <- map["from"]
        to <- map["to"]
        service_name <- map["service_name"]
        service_id <- map["service_id"]
        note <- map["note"]

        
    }
}
class TrialVersion : Mappable {
    
    var id                                                            :       String?
    var coachid                                                       :       String?
    var userid                                                        :       String?
    var from                                                          :       String?
    var to                                                            :       String?
    var day                                                           :       String?
    var is_synced                                                     :       String?
    var date                                                          :       String?
    var service_name                                                  :       String?
    var service_id                                                    :       String?
    var type                                                          :       String?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        coachid <- map["coachid"]
        userid <- map["userid"]
        from <- map["from"]
        to <- map["to"]
        day <- map["day"]
        is_synced <- map["is_synced"]
        date <- map["date"]
        service_name <- map["service_name"]
        service_id <- map["service_id"]
        type <- map["type"]

        
    }
}

class UserHealth : Mappable {
    
    var id                                                 :       String?
    var metabolic                                          :       String?
    var muscle                                             :       String?
    var userid                                             :       String?
    var water                                              :       String?
    var weight                                             :       String?
    var bmi                                                :       String?
    var bmr                                                :       String?
    var bone                                               :       String?
    var fat                                                :       String?
    var userId                                                :       String?

    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        metabolic <- map["metabolic"]
        muscle <- map["muscle"]
        userid <- map["userid"]
        water <- map["water"]
        weight <- map["weight"]
        bmi <- map["bmi"]
        bmr <- map["bmr"]
        bone <- map["bone"]
        fat <- map["fat"]
        userId <- map["userid"]

    }
}

class WaterToday : Mappable {
    
    var id                                                 :      String?
    var glass                                            :       String?
    var glass2                                          :       String?
    var glass3                                          :       String?
    var glass4                                          :       String?
    var glass5                                          :       String?
    var glass6                                          :       String?
    var chartData                                            :       WaterObject?

    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        glass <- map["glass"]
        glass2 <- map["glass2"]
        glass3 <- map["glass3"]
        glass4 <- map["glass4"]
        glass5 <- map["glass5"]
        glass6 <- map["glass6"]
        chartData <- map["chart_data"]

    }
}

class UserDetailObject : Mappable {
    
    var id                                                 :       Int?
    var allergies                                          :       String?
    var created                                             :       String?
    var current_living                                             :       String?
    var date_of_birth                                              :       String?
    var email                                             :       String?
    var first_name                                                :       String?
    var goal                                                :       String?
    var health_parents                                               :       String?
    var height                                                :       String?
    var hours_per_week                                                :       String?
    var interests                                                :       String?
    var last_name                                                :       String?
    var major_addiction                                                :       String?
    var medications                                                :       String?
    var nationality                                                :       String?
    var no_childs                                                :       String?
    var occupation                                                :       String?
    var preferred_style                                                :       String?
    var relation_status                                                :       String?
    var serious_illness                                                :       String?
    var sleep                                                :       String?
    var target_description                                                :       String?
    var target_weight                                                :       String?
    var terms_acceptance                                                :       String?
    var therapies                                                :       String?
    var weight                                                :       String?
    var profile_pic                                                :       String?
    var date_joined                                                :    String?
    var gender                                                :    String?
    var speciality                                                :    String?
    var hobby                                                :    String?
    var level                                                :    String?
    var bookafy                                                :    String?
    var phone                                                :    String?
    var is_online                                                :    String?
    var reason                                                :    String?
    var coach_id                                               : String?
    var coach_firstname                                       :  String?
    var coach_lastname                                       :  String?
    var coachPic                                             :  String?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        allergies <- map["allergies"]
        created <- map["created"]
        current_living <- map["current_living"]
        date_of_birth <- map["date_of_birth"]
        email <- map["email"]
        first_name <- map["first_name"]
        goal <- map["goal"]
        health_parents <- map["health_parents"]
        height <- map["height"]
        hours_per_week <- map["hours_per_week"]
        interests <- map["interests"]
        last_name <- map["last_name"]
        major_addiction <- map["major_addiction"]
        medications <- map["medications"]
        nationality <- map["nationality"]
        no_childs <- map["no_childs"]
        occupation <- map["occupation"]
        preferred_style <- map["preferred_style"]
        relation_status <- map["relation_status"]
        serious_illness <- map["serious_illness"]
        sleep <- map["sleep"]
        target_description <- map["target_description"]
        target_weight <- map["target_weight"]
        terms_acceptance <- map["terms_acceptance"]
        therapies <- map["therapies"]
        weight <- map["weight"]
        profile_pic <- map["profile_pic"]
        date_joined <- map["date_joined"]
        gender <- map["gender"]
        speciality <- map["speciality"]
        hobby <- map["hobby"]
        level <- map["level"]
        bookafy <- map["bookafy"]
        phone <- map["phone"]
        is_online <- map["is_online"]
        reason <- map["reason"]
        coach_id <- map["coach_id"]
        coach_firstname <- map["coach_firstname"]
        coach_lastname <- map["coach_lastname"]
        coachPic <- map["coach_pic"]
    }
}

class ExerciseObjects : Mappable {
    
    var id                                                   :       String?
    var distance                                             :       String?
    var calories                                             :       String?
    var type                                                 :       String?
    var duration                                             :       String?
    var notes                                                :       String?
    var start_datetime                                       :       String?
    var distances                                            :       String?
    var caloriess                                            :       String?
    var durations                                            :       String?
    var chartData                                            :       ExerciseObject?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        distance <- map["distance"]
        calories <- map["calories"]
        duration <- map["duration"]
        notes <- map["notes"]
        start_datetime <- map["start_datetime"]
        distances <- map["distance"]
        caloriess <- map["calories"]
        durations <- map["duration"]
        type      <-  map["type"]
        chartData      <-  map["chart_data"]

        
    }
}

class KitchenObject : Mappable {
    
    var id                                                 :       String?
    var image                                              :       String?
    var date_selected                                      :       String?
    var title                                              :       String?
    var user_id                                            :       String?
    var idOfItem                                           :       Int?

    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        image <- map["image"]
        date_selected <- map["date_selected"]
        title <- map["title"]
        user_id <- map["user_id"]
        idOfItem <- map["id"]

    }
}

class AddSleep : Mappable {
    
    var success                           :       Bool?
    var message                           :       String?
    var msg                               :       String?
    var status                            :       Int?
    var data                              :       SleepObject?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        msg   <- map["msg"]
        status   <- map["status"]
        data   <- map["data"]

    }
}


class SleepObject : Mappable {
    
    var weeklyData                                                :       [WeeklyData]?
    var monthly_data                                              :       [MonthlyData]?
    var yearlyData                                                :       [YearlyData]?
    var total_hours_weekly                                        :       Int?
    var total_hours_monthly                                       :       Int?
    var total_hours_yearly                                        :       Int?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        weeklyData <- map["weekly_data"]
        monthly_data <- map["monthly_data"]
        yearlyData   <- map["yearly_data"]
        total_hours_weekly <- map["total_hours_weekly"]
        total_hours_monthly <- map["total_hours_monthly"]
        total_hours_yearly <- map["total_hours_yearly"]
    }
}
class WaterObject : Mappable {
    
    var weeklyData                                                :       [WeeklyDataWater]?
    var monthly_data                                              :       [MonthlyDataWater]?
    var yearlyData                                                :       [YearlyDataWater]?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        weeklyData <- map["weekly_data"]
        monthly_data <- map["monthly_data"]
        yearlyData   <- map["yearly_data"]
        
        
        
        
    }
}

class ExerciseObject : Mappable {
    
    var weeklyData                                                :       [WeeklyDataExercise]?
    var monthly_data                                              :       [MonthlyDataExercise]?
    var yearlyData                                                :       [YearlyDataExercise]?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        weeklyData <- map["weekly_data"]
        monthly_data <- map["monthly_data"]
        yearlyData   <- map["yearly_data"]
        
        
        
        
    }
}



class WeeklyData : Mappable {
    
    var hours                                               :       Int?
    var day                                                 :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        hours <- map["hours"]
        day <- map["day"]
        
    }
}

class MonthlyData : Mappable {
    
    var week                                               :       String?
    var total                                                 :       Int?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        week <- map["week"]
        total <- map["total"]
        
    }
}


class YearlyData : Mappable {
    
    var total                                               :       Int?
    var month                                                 :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        total <- map["total"]
        month <- map["month"]
        
    }
}

class WeeklyDataWater : Mappable {
    
    var glasses                                               :       Int?
    var day                                                 :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        glasses <- map["glasses"]
        day <- map["day"]
        
    }
}

class MonthlyDataWater : Mappable {
    
    var total                                               :       Int?
    var week                                                 :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        total <- map["total"]
        week <- map["week"]
        
    }
}


class YearlyDataWater : Mappable {
    
    var total                                               :       Int?
    var month                                                 :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        total <- map["total"]
        month <- map["month"]
        
    }
}

class WeeklyDataExercise : Mappable {

    var duration                                               :       Int?
    var day                                                    :       String?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        duration <- map["duration"]
        day <- map["day"]
        
    }
}

class MonthlyDataExercise : Mappable {
    
    var total                                               :       Int?
    var week                                                 :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        total <- map["total"]
        week <- map["week"]
        
    }
}


class YearlyDataExercise : Mappable {
    
    var total                                               :       Int?
    var month                                                 :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        total <- map["total"]
        month <- map["month"]
        
    }
}


class AppointmentList : Mappable {
    
    var id                                                           :       Int?
    var service_name                                                 :       String?
    var duration                                                     :       String?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        service_name <- map["service_name"]
        duration <- map["duration"]

    }
}

class UploadPic : Mappable {
    
    var imagepath                                               :       String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        imagepath <- map["imagepath"]
        
    }
}

class PackageOfCoach : Mappable {

    var package                                                           :       PackageList?
    var defaultsItem                                                 :       [PackageList]?

    required init?(map: Map){
    }
    func mapping(map: Map) {
        package <- map["package"]
        defaultsItem <- map["default"]
    }
}



class PackageList : Mappable {

    var id                                                           :       String?
    var duration                                                 :       String?
    var price                                                     :       String?
    var description                                                     :       String?
    var start_date                                                     :       String?
    var end_date                                                     :       String?

    required init?(map: Map){
    }
    func mapping(map: Map) {
        id <- map["id"]
        duration <- map["duration"]
        price <- map["price"]
        description <- map["description"]
        start_date <- map["start_date"]
        end_date <- map["end_date"]

    }
}



class Coach : Mappable {
    
    var success                           :       Bool?
    var message                           :       String?
    var msg                               :       String?
    var status                            :       Int?
    var coachProfile                      :       CoachProfile?
    var coachSlot                         :       [CoachSlot]?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        status          <- map["status"]
        message         <- map["message"]
        msg              <- map["msg"]
        success            <- map["success"]
        coachProfile            <- map["data"]
        coachSlot               <- map["data"]
        
    }
}

class CoachProfile : Mappable {
    
    var name                           :       String?
    var profile_pic                           :       String?
    var gender                               :       String?
    var speciality                            :       String?
    var hobby                            :       String?
    var date_joined                            :       String?
    var hours_per_week                            :       String?
    var country                            :       String?
    var occupation                            :       String?
    var coachAppointMentList                :     [CoachAppointment]?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        name          <- map["name"]
        profile_pic         <- map["profile_pic"]
        gender              <- map["gender"]
        speciality            <- map["speciality"]
        hobby            <- map["hobby"]
        date_joined            <- map["date_joined"]
        hours_per_week            <- map["hours_per_week"]
        country            <- map["country"]
        occupation            <- map["occupation"]
        coachAppointMentList <- map["appointments"]
        
    }
}

class CoachAppointment : Mappable {
    
    var id                           :       String?
    var coachid                           :       String?
    var userid                               :       String?
    var from                            :       String?
    var to                            :       String?
    var day                            :       String?
    var is_synced                            :       String?
    var created_at                            :       String?
    var date                            :       String?
    var service_name                    : String?
    var service_id                    : String?

    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id          <- map["id"]
        coachid         <- map["coachid"]
        userid              <- map["userid"]
        from            <- map["from"]
        to            <- map["to"]
        day            <- map["day"]
        is_synced            <- map["is_synced"]
        created_at            <- map["created_at"]
        date            <- map["date"]
        service_name            <- map["service_name"]
        service_id            <- map["service_id"]

        
    }
}

class CoachSlot : Mappable {

    var time_from                           :       String?
    var time_to                           :       String?
    var is_booked                               :       Bool?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        time_from          <- map["time_from"]
        time_to         <- map["time_to"]
        is_booked              <- map["is_booked"]
        
    }
}

class FAQObject : Mappable {
    
    var success                           :       Bool?
    var message                           :       String?
    var msg                               :       String?
    var faqlist                         :       [FAQList]?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        message         <- map["message"]
        msg              <- map["msg"]
        success            <- map["success"]
        faqlist               <- map["data"]
        
    }
}

class FAQList : Mappable {
    
    var id                           :       String?
    var title                           :       String?
    var answer                               :       String?
    var created_at                            :       String?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id          <- map["id"]
        title         <- map["title"]
        answer              <- map["answer"]
        created_at            <- map["created_at"]
        
    }
}
